// function run_jspsych() {
//   jsPsych.init({
//     // timeline: new_timeline(),
//     timeline: timeline,
//     display_element: 'js_psych',
//     on_finish: function() {
//       var json_data = jsPsych.data.get().json();
//       Shiny.onInputChange("jspsych_results", json_data);
//       next_page();
//     }
//   });
// }
// run_jspsych();


// an array of paths to sound that need to be manually pre-loaded

// // pitch test trials
//     var audio = ['sounds/pitch/3-C3-8__4-C4-8.wav',
//     'sounds/pitch/3-C3-12__4-C4-4.wav',
//     'sounds/pitch/3-C3-16__4-C4-0.wav',
//     'sounds/pitch/3-C4-8__4-C3-8.wav',
//     'sounds/pitch/3-C4-12__4-C3-4.wav',
//     'sounds/pitch/3-C4-16__4-C3-0.wav',
// ];


// ratio test trials
var audio = [
  "sounds/ratio/f_2-3_80-120.wav",
  "sounds/ratio/f_2-5_48-120.wav",
  "sounds/ratio/f_3-5_72-120.wav",
  "sounds/ratio/m_3-4_90-120.wav",
  "sounds/ratio/s_2-3_90-135.wav",
  "sounds/ratio/s_2-5_90-225.wav",
  "sounds/ratio/s_3-5_90-150.wav",
];

function run_jspsych() {
  jsPsych.init({
    timeline: timeline,
    display_element: 'js_psych',
    preload_audio: audio,
    use_webaudio: true,
    on_finish: function() {
      var json_data = jsPsych.data.get().json();
      Shiny.onInputChange("jspsych_results", json_data);
      next_page();
    }
  });
}
run_jspsych();