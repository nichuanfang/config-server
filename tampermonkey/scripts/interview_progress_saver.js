// ==UserScript==
// @name         Interview Progress Saver
// @namespace    https://doc-blond-eight.vercel.app/interview
// @version      1.0
// @description  Save and restore progress on the interview website
// @author       ncf
// @match        https://doc-blond-eight.vercel.app/interview*
// @grant        GM_setValue
// @grant        GM_getValue
// ==/UserScript==

(function() {
    'use strict';

    var firstURL = window.location.href;
    // Function to save the current URL to localStorage every few seconds
    function saveProgress() {
        var currentURL = window.location.href;
        if (currentURL.startsWith('https://doc-blond-eight.vercel.app/interview/')) {
            localStorage.setItem('interview_progress', currentURL);
        }
    }

    // Function to check for saved progress and restore it
    function restoreProgress() {
        var savedProgress = localStorage.getItem('interview_progress');
        if (savedProgress && firstURL === 'https://doc-blond-eight.vercel.app/interview') {
            window.location.href = savedProgress;
        }
    }

    // Save the current URL every 5 seconds
    setInterval(saveProgress, 5000);

    // Restore progress when the script runs
    restoreProgress();
})();
