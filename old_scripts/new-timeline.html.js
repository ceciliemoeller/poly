function new_timeline() {
  //   var hello_trial = {
  //     type: 'html-keyboard-response',
  //     stimulus: 'TRYK NU!'      
  //   };
  //   return [hello_trial];
  // }

      var hello_trial = {
      type: 'audio-keyboard-response',
      stimulus: 'drums/ambi_-13-5_mono_short.wav', 
      choices: ['TAP HERE', 'NEXT']     
    };
    return [hello_trial];
  }
  // var soundcheck = [
  //   // { stimulus: "sounds/452sine.mp3", data: { test_part: 'soundcheck', correct_response: 'space' } }
  //   { stimulus: "ambi_-13-5_mono_short.wav" }
  // ];

  var trial = {
    type: 'audio-button-response',
    stimulus: 'drums/ambi_-13-5_mono_short.wav',
    choices: ['TAP HERE', 'NEXT'],
    prompt: "Is this activity healthy or unhealthy?"
};
return [trial]

// var trial_procedure = {
//   timeline: [trial],
//   timeline_variables: soundcheck,
//     }

// new_timeline.push(trial_procedure);
// return [trial];
};