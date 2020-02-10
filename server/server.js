const CronJob = require('cron').CronJob;
const WebSocket = require('ws');
const serverSocket = new WebSocket.Server({ port: 8080 });
const fs = require('fs');


var todayScore = 0;
var yesterdayScore = 0;
var highScore = 0;
init();

async function init() {
    await _readPersistedScores();

    // update/reset the scores every day at 00:00:00UTC
    new CronJob('* * * * * *', function () {
        // updateScores();
    }, null, true, 'UTC');

    // server starts listening for incoming client connections
    serverSocket.on('connection', _onClientConnected);

    console.log('Server started!');
}

function incrementTodayScore() {
    // Note: JavaScript is single-threaded so every operation is atomic.
    todayScore++;
    _broadcast(TodayScoreUpdatedEvent());

    // TODO: persist scores
}

function updateScores() {
    if (todayScore > highScore) {
        highScore = todayScore;
    }
    yesterdayScore = todayScore;
    todayScore = 0;
    _persistScores();

    _broadcast(ScoresUpdatedEvent());
}

function _onClientConnected(clientSocket) {
    // listen for messages sent from client 
    clientSocket.on('message', _handleClientMsg);

    // send the newly connected client the current drink scores
    clientSocket.send(ScoresUpdatedEvent());
}

function _broadcast(msg) {
    serverSocket.clients.forEach(function each(client) {
        if (client.readyState === WebSocket.OPEN) {
            client.send(msg);
        }
    });
}

function _handleClientMsg(msgStr) {
    let msg = JSON.parse(msgStr);
    if (msg.event == EventType.INCREMENT_TODAY_SCORE) {
        incrementTodayScore();
    } else {
        // ignore all other events
    }
}

function _readPersistedScores() {
    return new Promise(function (resolve, reject) {
        let rawdata = fs.readFileSync('scores.json');
        let scores = JSON.parse(rawdata);
        todayScore = scores.todayScore;
        yesterdayScore = scores.yesterdayScore;
        highScore = scores.highScore;
        console.log('read persistent scores: ' + scores);
        resolve();
    });
}

function _persistScores() {
    return new Promise(function (resolve, reject) {
        let scores = JSON.stringify({
            todayScore,
            yesterdayScore,
            highScore
        });
        fs.writeFileSync('scores.json', scores);
        console.log('persisted scores: ' + scores);
        resolve();
    });
}

const EventType = {
    SCORES_UPDATED: 0,
    TODAY_SCORE_UPDATED: 1,
    INCREMENT_TODAY_SCORE: 2,
};

const TodayScoreUpdatedEvent = function () {
    return JSON.stringify({
        event: EventType.TODAY_SCORE_UPDATED,
        data: {
            todayScore: todayScore
        }
    });
};

const ScoresUpdatedEvent = function () {
    return JSON.stringify({
        event: EventType.SCORES_UPDATED,
        data: {
            todayScore: todayScore,
            yesterdayScore: yesterdayScore,
            highScore: highScore
        }
    });
};
