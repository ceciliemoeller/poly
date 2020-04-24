
// function new_timeline() {
//   var hello_trial = {
//     type: 'audio-bpm-button-response',
//     stimulus: "sounds/pitch/3-C3-8__4-C4-8.wav",
//     choices: "virk nu!"
//   };
//   return [hello_trial];
// }



// function new_timeline() {


var timeline = [];

// var welcome = {
//   type: "html-button-response",
//   stimulus: "<p>In this experiment, we would like you to tap along to the beat of some musical rhythms.</p>" +
//     "In this pilot experiment, you will hear some musical rhythms." +
//     "We would like you to use a button on the screen to tap along to the beat of the sounds." +
//     "Here are some examples of what we mean when we say 'the beat':" +
//     "The beat is like a clock’s tick." +
//     "The beat is what you would naturally clap along to, or tap your foot to." +
//     "The beat is the steady pulse you feel when listening to music." +
//     "Your feet emphasize the beat when you walk at a constant pace in time with music.",

//   choices: ["Next"]
// };

// timeline.push(welcome);


/* assess natural pace (NP) */
var np_instr = {
  type: "html-button-response",
  stimulus: "<p>To warm up, we would like to start by asking you to tap at a steady rate that feels comfortable for you.</p>" +
    "<p>When you click the button below, you will hear a single whistle sound followed by silence.</p>" +
    "<p>Please start tapping your spontaneous steady rate when you hear the whistle, and continue to do so until you hear the whistle again.</p>",

  choices: ["Start"]
};

timeline.push(np_instr);

var nat_pace = {
  type: 'audio-bpm-button-response',
  stimulus: 'sounds/spontaneous_tap.wav',
  prompt: "<p class='largegap-above'>Please tap at a steady rate that feels comfortable for you.</p>",
  choices: ["<p class='font'> <strong>Tap here!</strong></p>"]

};

timeline.push(nat_pace);

/* define instructions trial */
var instructions = {
  type: "html-button-response",
  stimulus: "<h2><strong>Thank you.</strong></h2>" +
    "<p><strong>You are ready to start the tapping experiment.</strong></p>" +

    "<p class='largegap-above'> You will hear some musical rhythms. </p>" +
    "<p> Your task is to simply tap along to the underlying beat of the rhythms,</p>" +
    "<p> as you do for instance, when you are clapping your hands with the audience at a concert.</p>" +
    "<p class='gap-above'> You should not tap from the very beginning.</p>" +
    "<p> Just listen to the musical rhythms, take your time,</p>" +
    "<p> and start tapping whenever you feel the beat.</p>" +
    "<p> Please continue tapping until the sound stops.</p>",
  choices: ["Start the experiment"],
  post_trial_gap: 2000
};
timeline.push(instructions);

// // pitch test trials
// var test_stimuli = [
//     { stimulus: "sounds/pitch/3-C3-8__4-C4-8.wav" },
//     { stimulus: "sounds/pitch/3-C3-12__4-C4-4.wav" },
//     //   { stimulus: "sounds/pitch/3-C3-16__4-C4-0.wav"},
//     //   { stimulus: "sounds/pitch/3-C4-8__4-C3-8.wav"},
//     //   { stimulus: "sounds/pitch/3-C4-12__4-C3-4.wav"},
//     //   { stimulus: "sounds/pitch/3-C4-16__4-C3-0.wav"},
// ];

// ratio test trials
var test_stimuli = [
  { stimulus: "sounds/ratio/f_2-3_80-120.wav" },
  { stimulus: "sounds/ratio/f_2-5_48-120.wav" },
  { stimulus: "sounds/ratio/f_3-5_72-120.wav" },
  { stimulus: "sounds/ratio/m_3-4_90-120.wav" },
  { stimulus: "sounds/ratio/s_2-3_90-135.wav" },
  { stimulus: "sounds/ratio/s_2-5_90-225.wav" },
  { stimulus: "sounds/ratio/s_3-5_90-150.wav" },
];



var test = {
  type: "audio-bpm-button-response",
  stimulus: jsPsych.timelineVariable('stimulus'),
  prompt: "<p>Use your touch screen, touch pad or mouse (left click)</p>",
    
  choices: ["<p class='font'> <strong>Tap here!</strong></p>"],
  post_trial_gap: 000
  //   response_ends_trial: false
}

var fixation = {
  type: 'html-button-response',
  stimulus: "<p>Great! </p>" +
    "<p>Take a small break if you like.</p>" +
    "<p> When you are ready,</p>" +
    "<p>click below to proceed.</p>",
  choices: ["Next"]
}

var test_procedure = {
  timeline: [test, fixation],
  timeline_variables: test_stimuli,
  randomize_order: true,
  repetitions: 1
}


timeline.push(test_procedure);


//   var timeline = [];

// var welcome = {
//     type: "html-button-response",
//     stimulus: "Testing BPM plugin. ",
//     choices:["Tap here to proceed."]
//   };

//  timeline.push(welcome);

//   var three_trial = {
//   type: "audio-bpm-button-response",
//   stimulus: "sounds/pitch/3-C3-8__4-C4-8.wav",
//   choices: ["here"]
// };
// timeline.push(three_trial)

// var four_trial = {
//   type: "audio-bpm-button-response",
//   stimulus: "sounds/pitch/3-C4-8__4-C3-8.wav",
//   choices: ["there"]
// };
// timeline.push(four_trial);

// // timeline = timeline.concat(welcome, three_trial, four_trial)
// // return [timeline]
// // }
