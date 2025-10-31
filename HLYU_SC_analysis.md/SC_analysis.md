Butterfly Effect - Analog Tara

A four-channel composition made in the programming environment SuperCollider, with a generative structure that unfolds unpredictably and differently each time it is executed. Its structure is derived from behavioral aspects and ecosystem dynamics of migratory monarch butterflies and inspired by the “butterfly effect” concept of chaos theory, which suggests that the flapping of one butterfly’s wings can cause significant changes in how a weather system unfolds over time.


Each synthesized sound event represents either a butterfly behavior (like flying or clustering), or an environmental condition (like wind or sunlight). All sequences of sound events result from the interdependence of fluctuating elements in the whole system. SuperCollider code becomes a poetic as well as a functional programming language, as data objects that are created and destroyed reference the life cycles of living things. Although the composition generates indefinitely, most sound elements cycle through in a 24-minute period (where each minute represents one hour in the synthesized environment).

How the “Circadian Routine” Translates Time into Music

Main Idea:In Butterfly , it simulates a day cycle as a musical timeline.Each “hour” in the program represents one musical segment that controls sound behavior.

How It Works:
When ~i reaches 23, it resets to 0 → a new “day” begins.
~sunrise and ~daylight determine when it’s daytime or nighttime.
Different sounds (butterflies, light, crickets) activate depending on the time of day and weather.

Conceptually:
The code is the clock, and
The music is the passing of time.

Each full 24-hour loop forms one complete musical day, where sonic events mirror natural rhythms — dawn, daylight, dusk, and night.


***Code https://www.analogtara.net/butterfly-effects/
// circadian routine: controls timing of events in overall composition,
// and triggers sun, light & cricket synths

~circadian = Routine({
    ~flapping.play; ~flapping.reset;
    ~daylight=12;
    ~sunrise=6;
    ~dayNum=1; // ctr of days

    inf.do{|i|
        "day "++~post; ~dayNum.post; " hour "++i.postln;
        if (i == 23, {i=0; ~dayNum=~dayNum+1});

        // resets counter (ctr) every 24 hrs(mins) & increments no. of days
        case
        { (i <= ~sunrise) || (i >= (~daylight + ~sunrise)) } {
            ~isNight.play; ~nightTime = true; ~light.reset;
        }
        { (i > ~sunrise) && (i < (~daylight + ~sunrise)) } {
            ~day.play; ~nightTime = false; ~day.reset;
        };

        case
        { i == 4 } { ~conserve.play; ~conserve.reset }
        { i == 10 } { ~disperse.play; ~disperse.reset }
        { (i - ~sunrise) % 6 == 0 } { ~light.play; ~light.reset }
        { (i == 3) || (i == 13) } { ~fly.play; ~fly.reset };

        // above functions trigger butterfly actions based on time of day
        // and amount of light

        case
        { (~raining == false) && ((i == 2) || (i == 20) || (i == 21) || (i == 22)) } {
            if (~crix.play, "not raining, crickets start".postln; ~crix.reset);
            (~crix.isPlaying == true) || (
                (~raining == true) && (~crix.isPlaying == true)
                if {~crix.stop; "crickets stop".postln}
            );
            // crickets play during limited nighttime hours
            // only when it is not raining
        };

        1.wait;
        i=i+1;
    }
}).play;


```
***
Theme: Modeling nature’s circadian rhythm through sound
Each “day” contains events like sunrise, daylight, rain, nighttime
Synths represent living agents: butterflies, crickets, and light
Time-based triggers mirror ecological behaviors


***
Defines a continuous Routine controlling events each simulated hour
Initializes environmental variables (daylight length, sunrise time, counters)
Infinite loop (inf.do) → 1 iteration = 1 hour of the composition


***
Variable meanings
~i → current hour (0–23)
~sunrise → sunrise time (e.g., 6)
~daylight → length of the day (e.g., 12)

Condition 1:(~i <= ~sunrise) || (~i > (~daylight + ~sunrise))→ 
When the current time is before sunrise (0–6) or after sunset (>18),the system sets night mode:~night.play, ~nightTime = true.

Condition 2:(~i > ~sunrise) && (~i <= (~daylight + ~sunrise))→ 
When time is between sunrise and sunset (6–18),the system sets day mode:~day.play, ~nightTime = false.


Each time slot triggers a behavioral synth• 04h – Conserve energy• 10h – Disperse• Noon – Light intensifies• 13h – Butterfly flight
Represents life-cycle stages within a single day
```

