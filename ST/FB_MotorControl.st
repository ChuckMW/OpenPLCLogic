FUNCTION_BLOCK MotorControl
VAR_INPUT
    Start : BOOL;              // Start command
    Stop : BOOL;               // Stop command
    Forward : BOOL;            // Forward direction command
    Reverse : BOOL;            // Reverse direction command
    FaultReset : BOOL;         // Reset fault command
    FaultDetected : BOOL;      // Fault signal from motor
END_VAR

VAR_OUTPUT
    MotorRunning : BOOL;       // Indicates if the motor is running
    MotorDirection : STRING[10]; // "Forward" or "Reverse"
    MotorDirectionControl : BOOL ; //Bool output of motor direction TRUE == REV, FALSE == FOR;
    FaultActive : BOOL;        // Indicates if a fault is active
END_VAR


    // Handle fault condition
    IF FaultDetected THEN
        FaultActive := TRUE;
        MotorRunning := FALSE;
    END_IF;

    // Reset fault
    IF FaultReset THEN
        FaultActive := FALSE;
    END_IF;

    // Stop motor
    IF Stop THEN
        MotorRunning := FALSE;
    END_IF;

    // Start motor
    IF Start AND NOT FaultActive THEN
        MotorRunning := TRUE;

        // Set direction
        IF Forward THEN
            MotorDirection := 'Forward';
            MotorDirectionControl := FALSE;
        ELSIF Reverse THEN
            MotorDirection := 'Reverse';
            MotorDirectionControl := TRUE;
        ELSE
            MotorDirection := 'Unknown_Error';
        END_IF;
    END_IF;
