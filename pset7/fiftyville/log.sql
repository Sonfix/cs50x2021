-- Keep a log of any SQL queries you execute as you solve the mystery.

--first getting an overview be running
.schema

-- getting the reported thefts on given date an street
SELECT * FROM crime_scene_reports WHERE month = 7 AND DAY = 28 AND street = "Chamberlin Street";

-- result:
-- 295 | 2020 | 7 | 28 | Chamberlin Street | Theft of the CS50 duck took place at 10:15am at the Chamberlin Street courthouse. Interviews were conducted today with three witnesses who were present at the time — each of their interview transcripts mentions the courthouse.

-- getting the interviews accroding date and time of theft
SELECT * FROM interviews WHERE year = 2020 AND month = 7 AND day = 28

-- result:
--158 | Jose | 2020 | 7 | 28 | “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”
--159 | Eugene | 2020 | 7 | 28 | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”
--160 | Barbara | 2020 | 7 | 28 | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.
-- check these below
--161 | Ruth | 2020 | 7 | 28 | Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away. If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that time frame.
--162 | Eugene | 2020 | 7 | 28 | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at the courthouse, I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.
--163 | Raymond | 2020 | 7 | 28 | As the thief was leaving the courthouse, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- getting the information from courthose accoding to Ruth
SELECT * FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25;
--result:
--258 | 2020 | 7 | 28 | 10 | 8 | entrance | R3G7486
--259 | 2020 | 7 | 28 | 10 | 14 | entrance | 13FNH73
-- only looking for exiting
--260 | 2020 | 7 | 28 | 10 | 16 | exit | 5P2BI95
--261 | 2020 | 7 | 28 | 10 | 18 | exit | 94KL13X
--262 | 2020 | 7 | 28 | 10 | 18 | exit | 6P58WS2
--263 | 2020 | 7 | 28 | 10 | 19 | exit | 4328GD8
--264 | 2020 | 7 | 28 | 10 | 20 | exit | G412CB7
--265 | 2020 | 7 | 28 | 10 | 21 | exit | L93JTIZ
--266 | 2020 | 7 | 28 | 10 | 23 | exit | 322W7JE
--267 | 2020 | 7 | 28 | 10 | 23 | exit | 0NTHK55

--getting people from licsene plate
SELECT * FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit");
--result
--id | name | phone_number | passport_number | license_plate
--221103 | Patrick | (725) 555-4692 | 2963008352 | 5P2BI95
--243696 | Amber | (301) 555-4174 | 7526138472 | 6P58WS2
--396669 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ
--398010 | Roger | (130) 555-0289 | 1695452385 | G412CB7
--467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8
--514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
--560886 | Evelyn | (499) 555-9472 | 8294398571 | 0NTHK55
--686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X

--getting withdraws from atm on fiver street
SELECT * FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw";
--result:
--246 | 28500762 | 2020 | 7 | 28 | Fifer Street | withdraw | 48
--264 | 28296815 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
--266 | 76054385 | 2020 | 7 | 28 | Fifer Street | withdraw | 60
--267 | 49610011 | 2020 | 7 | 28 | Fifer Street | withdraw | 50
--269 | 16153065 | 2020 | 7 | 28 | Fifer Street | withdraw | 80
--288 | 25506511 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
--313 | 81061156 | 2020 | 7 | 28 | Fifer Street | withdraw | 30
--336 | 26013199 | 2020 | 7 | 28 | Fifer Street | withdraw | 35

--getting the people who actually have been at the atm
SELECT * FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw");
--result:
--686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X | 49610011 | 686048 | 2010
--514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE | 26013199 | 514354 | 2012
--458378 | Roy | (122) 555-4581 | 4408372428 | QX4YZN3 | 16153065 | 458378 | 2012
--395717 | Bobby | (826) 555-1652 | 9878712108 | 30G67EN | 28296815 | 395717 | 2014
--396669 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ | 25506511 | 396669 | 2014
--467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8 | 28500762 | 467400 | 2014
--449774 | Madison | (286) 555-6063 | 1988161715 | 1106N58 | 76054385 | 449774 | 2015
--438727 | Victoria | (338) 555-6650 | 9586786673 | 8X428L0 | 81061156 | 438727 | 2018

-- now check wether we got an intersection of those wo were widthdrawing money and were at the courthose
SELECT * FROM people WHERE id IN (
    SELECT id FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
    INTERSECT
    SELECT p.id FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
);

--result:
--396669 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ
--467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8
--514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
--686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X

-- so one of those has to be it. Now we need to check the phone calls
SELECT * FROM phone_calls WHERE caller IN (
 SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
    INTERSECT
    SELECT p.phone_number FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
)
AND duration < 60;
--results:
--233 | (367) 555-5533 | (375) 555-8161 | 2020 | 7 | 28 | 45
--255 | (770) 555-1861 | (725) 555-3243 | 2020 | 7 | 28 | 49
--395 | (367) 555-5533 | (455) 555-5315 | 2020 | 7 | 30 | 31

-- first get the reviecer persons to have a better understanding
SELECT * FROM people WHERE phone_number IN (
    SELECT receiver FROM phone_calls WHERE caller IN (
     SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
        INTERSECT
        SELECT p.phone_number FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
    )
    AND duration < 60
);

--results:
--639344 | Charlotte | (455) 555-5315 | 7226911797 | Z5FH038
--847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6
--864400 | Berthold | (375) 555-8161 |  | 4V16VO0

--also get the caller persons
SELECT * FROM people WHERE phone_number IN (
    SELECT caller FROM phone_calls WHERE caller IN (
     SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
        INTERSECT
        SELECT p.phone_number FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
    )
    AND duration < 60
);
--results:
--514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
--686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X


-- one of them has to be accomplice, check if one booked a flight from fiftyville
SELECT * FROM people WHERE passport_number IN (
    SELECT passport_number FROM passengers WHERE flight_id IN (
        SELECT id FROM flights WHERE origin_airport_id IN (
            SELECT id FROM airports WHERE city = "Fiftyville"
        )
    )
)
INTERSECT
SELECT * FROM people WHERE phone_number IN (
    SELECT receiver FROM phone_calls WHERE caller IN (
     SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
        INTERSECT
        SELECT p.phone_number FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
    )
    AND duration < 60
);

--result:
--639344 | Charlotte | (455) 555-5315 | 7226911797 | Z5FH038
--847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6

--we are getting close! now check for the first flight
SELECT * FROM people WHERE passport_number IN (
    SELECT passport_number FROM passengers WHERE flight_id IN (
        SELECT id FROM flights WHERE origin_airport_id IN (
            SELECT id FROM airports WHERE city = "Fiftyville"
        )
        AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour ASC, minute ASC
    )
)
INTERSECT
SELECT * FROM people WHERE phone_number IN (
    SELECT caller FROM phone_calls WHERE caller IN (
     SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
        INTERSECT
        SELECT p.phone_number FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
    )
    AND duration < 60
);
--results:
--514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
--686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X

--ok, these two are leaving. now check the flights
SELECT * FROM flights WHERE origin_airport_id IN (
        SELECT id FROM airports WHERE city = "Fiftyville"
    )
AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour ASC, minute ASC LIMIT 1;

--result: this is the flight!
--36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

--now get the destination
SELECT * FROM airports WHERE id = (
    SELECT destination_airport_id FROM flights WHERE origin_airport_id IN (
            SELECT id FROM airports WHERE city = "Fiftyville"
        )
    AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour ASC, minute ASC LIMIT 1
);

--result: here has he went to!
--4 | LHR | Heathrow Airport | London

--get the pesrons who went there & intersect with our supects:
SELECT * FROM people WHERE passport_number IN (
    SELECT passport_number FROM passengers WHERE flight_id IN (
        SELECT id FROM flights WHERE origin_airport_id IN (
            SELECT id FROM airports WHERE city = "Fiftyville"
        )
        AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour ASC, minute ASC LIMIT 1
    )
)
INTERSECT
    SELECT * FROM people WHERE passport_number IN (
        SELECT passport_number FROM passengers WHERE flight_id IN (
            SELECT id FROM flights WHERE origin_airport_id IN (
                SELECT id FROM airports WHERE city = "Fiftyville"
            )
            AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour ASC, minute ASC
        )
    )
    INTERSECT
    SELECT * FROM people WHERE phone_number IN (
        SELECT caller FROM phone_calls WHERE caller IN (
         SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 5 AND 25 AND activity = "exit")
            INTERSECT
            SELECT p.phone_number FROM people p, bank_accounts ba WHERE p.id = ba.person_id AND ba.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2020 AND month = 7 and day = 28 AND atm_location = "Fifer Street" AND transaction_type = "withdraw")
        )
        AND duration < 60
    )
;

--result: this is our thief!
-- 686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X

-- now check who he has actually called
SELECT * FROM people WHERE phone_number IN (
        SELECT receiver FROM phone_calls WHERE year = 2020 AND month = 7 AND day = 28
        AND duration < 60
        AND caller = (
            SELECT phone_number FROM people WHERE name = "Ernest"
        )
    );

-- got him:
--864400 | Berthold | (375) 555-8161 |  | 4V16VO0