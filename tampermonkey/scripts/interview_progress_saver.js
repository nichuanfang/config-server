// ==UserScript==
// @name         Interview Progress Saver
// @namespace    https://github.com/nichuanfang/config-server/blob/master/tampermonkey/scripts/interview_progress_saver.js
// @version      1.0
// @description  Save and restore progress on the interview website
// @author       ncf
// @match        https://doc.jaychou.site/interview/*
// @grant        GM_setValue
// @grant        GM_getValue
// ==/UserScript==

(function() {
    'use strict';

    let firstURL = window.location.href;
    // Function to save the current URL to localStorage every few seconds
    function saveProgress() {
        let currentURL = window.location.href;
        if (currentURL.startsWith('https://doc.jaychou.site/interview/')) {
            localStorage.setItem('interview_progress', currentURL);
        }
    }

    // Function to check for saved progress and restore it
    function restoreProgress() {
        let savedProgress = localStorage.getItem('interview_progress');
        if (savedProgress && firstURL === 'https://doc.jaychou.site/interview/') {
            window.location.replace(savedProgress);
        }
    }

    // Save the current URL every 5 seconds
    setInterval(saveProgress, 5000);

    // Restore progress when the script runs
    restoreProgress();
})();
