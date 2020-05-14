var stimuliExpRandomizer = {},
    stimuliExpRandomizerRandomNb = Math.floor(Math.random() * 3);
  

/**
 * This function takes a type parameter, deciding
 * if we are asking for preload or exp data.
 * 
 * When requesting preload data, we take a random
 * array of stimulis. This result is stores so that
 * we can return the same array when asking for exp data.
 */
stimuliExpRandomizer.randomizeStimuli = function(type) {
    var randomNb = stimuliExpRandomizerRandomNb;
    var dataArray = [
            [
                "sounds/pitch/3-c4-08_4-c6-8.wav",
                "sounds/pitch/3-c4-12_4-c6-4.wav",
                "sounds/pitch/3-c4-16_4-c6-0.wav",
                "sounds/pitch/3-c6-08_4-c4-8.wav",
                "sounds/pitch/3-c6-12_4-c4-4.wav",
                "sounds/pitch/3-c6-16_4-c4-0.wav",
                 
            ],
            [
                "sounds/tempo/67.5-90_-8-8.wav",
                "sounds/tempo/67.5-90_-12-4.wav",
                "sounds/tempo/67.5-90_-16-0.wav",
                "sounds/tempo/90-120_-8-8.wav",
                "sounds/tempo/90-120_-12-4.wav",
                "sounds/tempo/90-120_-16-0.wav",
                "sounds/tempo/120-160_-8-8.wav",
                "sounds/tempo/120-160_-12-4.wav",
                "sounds/tempo/120-160_-16-0.wav",   
            ],
            [
                "sounds/ratio/f_2-3_80-120.wav",
                "sounds/ratio/f_2-5_48-120.wav",
                "sounds/ratio/f_3-5_72-120.wav",
                "sounds/ratio/m_3-4_90-120.wav",
                "sounds/ratio/s_2-3_90-135.wav",
                "sounds/ratio/s_2-5_90-225.wav",
                "sounds/ratio/s_3-5_90-150.wav",    
            ],
        ];
    switch (type) {
        case 'preload':
            console.log('number is ' + randomNb)
            return dataArray[randomNb]
            break;
        case 'exp':
            console.log('number is ' + randomNb)
            return stimuliExpRandomizer.createExpArray(dataArray[randomNb])
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