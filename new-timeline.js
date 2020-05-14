
// Don't do this (i.e. create a function) if you need to implement it into PsychTestR:
// function new_timeline() {...


var timeline = [];

var calibrate = {
  type: "html-button-response",
  stimulus: "<p>[This calibration page is yet to come... Calibration stim have to match experiment... Check whether preloading is needed and if so, how to only preload exp-specific calibration stim.... later skater]</p>",

  choices: ["Start"]
};
timeline.push(calibrate);
// p("This allows you to adjust the volume of your device to a comfortable level where you can clearly hear the sounds."),

/* assess spontaneous motor speed (SMS) */
var sms_instr = {
  type: "html-button-response",
  stimulus: "<h4><strong>Almost ready</strong></h4>" +
  "<p>To warm up, we would like to start by asking you to tap at a steady rate that feels comfortable for you.</p>" +
    "<p>When you click the button below, you will hear a single whistle sound followed by silence.</p>" +
    "<p>Please start tapping your spontaneous steady rate when you hear the whistle, and continue to do so until you hear the whistle again.</p>",

  choices: ["Start"]
};

timeline.push(sms_instr);

var nat_pace = {
  type: 'audio-bpm-button-response',
  stimulus: 'sounds/spontaneous_tap.wav',
  prompt: "<p class='largegap-above'>Please tap at a steady rate that feels comfortable for you.</p>",
  choices: ["<p class='font'> <strong>Tap here!</strong></p>"]

};

timeline.push(nat_pace);

/* define instructions trial */
var instructions_I = {
  type: "html-button-response",
  stimulus: "<h4><strong>Thank you.</strong></h4>" +
    "<p><strong>You are ready to start the tapping experiment.</strong></p>" +
    "<p>Here is what will happen:</p>" +
    "<p class='gap-above'> You will hear some musical rhythms.</p>" +
    "<p>Your task is to simply tap along to the underlying beat of the rhythms,</p>" +
    "<p>as you do for instance, when you are clapping your hands with the audience at a concert.</p>" ,
  choices: ["Next"],
  };
timeline.push(instructions_I);

var instructions_II = {
  type: "html-button-response",
  stimulus: "<p class='gap-above'> To make sure we are on the same page, here are some examples of what we mean when we say 'the beat':</p>" +
      
      "<p class='gap-above'> The beat is like a clock’s tick.</p>" +
      "<p>The beat is the steady pulse you feel when listening to music.</p>" +
      "<p>The beat is what you would naturally clap along to, or tap your foot to.</p>" +
      "<p>Your feet emphasize the beat when you walk at a constant pace in time with music.</p>",
  choices: ["Next"],
  };
timeline.push(instructions_II);

var instructions_III = {
  type: "html-button-response",
  stimulus: "<p class='gap-above'> Some of the rhythms are rather complex. Do not try to imitate the rhythms.</p>" +
    "<p>Simply tap along to the steady underlying beat.</p>" +
    "<p class='gap-above'>You should not tap from the very beginning.</p>" +
    "<p>Just listen to the musical rhythms, take your time,</p>" +
    "<p>and start tapping whenever you feel the beat.</p>" +
    "<p>Please continue tapping until the sound stops.</p>" +
    "<p>Are you ready? Good luck!</p>",
  choices: ["Start the experiment"],
  post_trial_gap: 2000
};
timeline.push(instructions_III);


// TEST STIMULI HERE:

// // tempo test trials
// var test_stimuli = [
//     { stimulus: "sounds/tempo/3-C3-8__4-C4-8.wav" },
//     { stimulus: "sounds/tempo/3-C3-12__4-C4-4.wav" },
//     //   { stimulus: "sounds/tempo/3-C3-16__4-C4-0.wav"},
//     //   { stimulus: "sounds/tempo/3-C4-8__4-C3-8.wav"},
//     //   { stimulus: "sounds/tempo/3-C4-12__4-C3-4.wav"},
//     //   { stimulus: "sounds/tempo/3-C4-16__4-C3-0.wav"},
// ];


// // pitch test trials
var test_audio = [{stimulus: "sounds/poly_pitch_marimba_loudness.wav"}]

// var test_stimuli = [
//     { stimulus: "sounds/pitch/3-C3-8__4-C4-8.wav" },
//     { stimulus: "sounds/pitch/3-C3-12__4-C4-4.wav" },
//     //   { stimulus: "sounds/pitch/3-C3-16__4-C4-0.wav"},
//     //   { stimulus: "sounds/pitch/3-C4-8__4-C3-8.wav"},
//     //   { stimulus: "sounds/pitch/3-C4-12__4-C3-4.wav"},
//     //   { stimulus: "sounds/pitch/3-C4-16__4-C3-0.wav"},
// ];

// ratio test trials
var test_audio = [{stimulus: "sounds/poly_ratio_loudness_check.wav"}]

var test_stimuli = stimuliExpRandomizer.randomizeStimuli('exp');
// [
//   { stimulus: "sounds/ratio/f_2-3_80-120.wav" },
//   { stimulus: "sounds/ratio/f_2-5_48-120.wav" },
//   { stimulus: "sounds/ratio/f_3-5_72-120.wav" },
//   { stimulus: "sounds/ratio/m_3-4_90-120.wav" },
//   { stimulus: "sounds/ratio/s_2-3_90-135.wav" },
//   { stimulus: "sounds/ratio/s_2-5_90-225.wav" },
//   { stimulus: "sounds/ratio/s_3-5_90-150.wav" },
// ];



var test = {
  type: "audio-bpm-button-response",
  stimulus: jsPsych.timelineVariable('stimulus'),
  prompt: "<p>Use your touch screen, touch pad or mouse (left click)</p>",
    
  choices: ["<p class='font'> <strong>Tap here!</strong></p>"],
  post_trial_gap: 000
  //   response_ends_trial: false
}


var rating = {
  type: "html-slider-response",
  stimulus: "<p>In this example,</p>"+
  "<p>how easy was it for you to find the beat?</p>",
  // "<p>Your rating will start the next trial.</p>" , 
  labels: ["<p>very easy</p>", 'very difficult'],
  // min: 1,
  // max: 9,
  // start: 5,
  require_movement: true
  // choices: ["1 - extremely easy", "2","3","4","5","6","7","8","9 - extremely difficult"]
};


// var fixation = {
//   type: 'html-button-response',
//   stimulus: "<p>Great! </p>" +
//     "<p>Take a small break if you like.</p>" +
//     "<p> When you are ready,</p>" +
//     "<p>click below to proceed.</p>",
//   choices: ["Next"]
// }

var test_procedure = {
  timeline: [test, rating],
  // timeline: [test, fixation],
  timeline_variables: test_stimuli,
  randomize_order: true,
  repetitions: 1
}


timeline.push(test_procedure);

