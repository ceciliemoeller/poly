var stimuliExpRandomizer = {},
    stimuliExpRandomizerRandomNb = Math.floor(Math.random() * 10);

if (stimuliExpRandomizerRandomNb < 3){
    stimuliExpRandomizerRandomNb = 0;
}
else if (stimuliExpRandomizerRandomNb < 6){
    stimuliExpRandomizerRandomNb = 1;
}
else {
    stimuliExpRandomizerRandomNb = 2;
}


/**
 * This function takes a type parameter, deciding
 * if we are asking for preload or exp data.
 * 
 * When requesting preload data, we take a random
 * array of stimulis. This result is stored so that
 * we can return the same array when asking for exp data.
 */
stimuliExpRandomizer.randomizeStimuli = function(type) {
    var randomNb = stimuliExpRandomizerRandomNb,
        sound_check_stim = [
            "sounds/pitch/poly_pitch_marimba_loudness.mp3",
            "sounds/tempo/poly_tempo_loudness_check.mp3",
            "sounds/ratio/poly_ratio_loudness_check.mp3",
        ],
        dataArray = [
            [
                "sounds/pitch/2-C3-1_3-C5-13.mp3",
                "sounds/pitch/2-C3-4_3-C5-10.mp3",
                "sounds/pitch/2-C3-7_3-C5-7.mp3",
                "sounds/pitch/2-C5-1_3-C3-13.mp3",
                "sounds/pitch/2-C5-4_3-C3-10.mp3",
                "sounds/pitch/2-C5-7_3-C3-7.mp3",           
                "sounds/pitch/3-C3-7_4-C5-7.mp3",
                "sounds/pitch/3-C3-10_4-C5-4.mp3",
                "sounds/pitch/3-C3-13_4-C5-1.mp3",
                "sounds/pitch/3-C5-7_4-C3-7.mp3",
                "sounds/pitch/3-C5-10_4-C3-4.mp3",
                "sounds/pitch/3-C5-13_4-C3-1.mp3"            
            ],
            [
                "sounds/tempo/2_3_40_60.mp3",
                "sounds/tempo/2_3_60_90.mp3",
                "sounds/tempo/2_3_90_135.mp3",
                "sounds/tempo/2_3_120_180.mp3",
                "sounds/tempo/2_3_135_202.5.mp3",
                "sounds/tempo/2_3_168.7_253.1.mp3",
                "sounds/tempo/2_3_202.5_303.7.mp3",
                "sounds/tempo/2_3_303.7_455.6.mp3",
                "sounds/tempo/3_4_38_50.6.mp3",
                "sounds/tempo/3_4_50.6_67.5.mp3",
                "sounds/tempo/3_4_67.5_90.mp3",
                "sounds/tempo/3_4_90_120.mp3",
                "sounds/tempo/3_4_120_160.mp3",
                "sounds/tempo/3_4_160_213.3.mp3",
                "sounds/tempo/3_4_186.7_248.9.mp3",
                "sounds/tempo/3_4_213.3_284.4.mp3",
                "sounds/tempo/3_4_284.4_379.2.mp3",
                "sounds/tempo/3_4_379.2_505.7.mp3"
            ],
            [
                "sounds/ratio/ratio_subdiv_63ms_3_5.mp3",
                "sounds/ratio/ratio_subdiv_63ms_4_5.mp3",
                "sounds/ratio/ratio_subdiv_63ms_5_6.mp3",
                "sounds/ratio/ratio_subdiv_84ms_3_5.mp3",
                "sounds/ratio/ratio_subdiv_84ms_4_5.mp3",
                "sounds/ratio/ratio_subdiv_84ms_5_6.mp3",
                "sounds/ratio/ratio_subdiv_125ms_2_3.mp3",
                "sounds/ratio/ratio_subdiv_125ms_2_5.mp3",
                "sounds/ratio/ratio_subdiv_125ms_3_4.mp3",
                "sounds/ratio/ratio_subdiv_125ms_3_5.mp3",
                "sounds/ratio/ratio_subdiv_125ms_4_5.mp3",
                "sounds/ratio/ratio_subdiv_125ms_5_6.mp3",
                "sounds/ratio/ratio_subdiv_167ms_2_3.mp3",
                "sounds/ratio/ratio_subdiv_167ms_2_5.mp3",
                "sounds/ratio/ratio_subdiv_167ms_3_4.mp3",
                "sounds/ratio/ratio_subdiv_167ms_3_5.mp3",
                "sounds/ratio/ratio_subdiv_167ms_4_5.mp3",
                "sounds/ratio/ratio_subdiv_167ms_5_6.mp3",
                "sounds/ratio/ratio_subdiv_250ms_2_3.mp3",
                "sounds/ratio/ratio_subdiv_250ms_2_5.mp3",
                "sounds/ratio/ratio_subdiv_333ms_2_3.mp3",
                "sounds/ratio/ratio_subdiv_333ms_2_5.mp3"    
            ],
        ];

    switch (type) {
        case 'preload':
            console.log('number is ' + randomNb)
            return dataArray[randomNb]
            break;
        case 'exp':
            console.log('number is ' + randomNb)
            return [sound_check_stim[randomNb],stimuliExpRandomizer.createExpArray(dataArray[randomNb])]
            break;
        default:
            break;
    }
}

stimuliExpRandomizer.createExpArray = function(myArray) {
    var myObj = {},
        myNewArray = [];
    myArray.forEach(element => {
        myObj = { 'stimulus': element };
        myNewArray.push(myObj)
    });
    console.dir(myNewArray)
    return myNewArray;
}