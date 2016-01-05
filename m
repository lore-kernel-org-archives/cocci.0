From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 05 Jan 2016 14:49:40 +0100
Subject: [Cocci] [PATCH v6] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <CAGG-pUSfBLeyktSP=u-rzjH+Q1LUcdKnh4H9ssTguL5WnKRkZw@mail.gmail.com>
References: <alpine.DEB.2.02.1512301502100.2048@localhost6.localdomain6>
 <1451893531-15817-1-git-send-email-a.hajda@samsung.com>
 <CAGG-pUSfBLeyktSP=u-rzjH+Q1LUcdKnh4H9ssTguL5WnKRkZw@mail.gmail.com>
Message-ID: <568BC9F4.6020409@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/05/2016 01:59 PM, Geyslan G. Bem wrote:
> Hello,
>
> 2016-01-04 4:45 GMT-03:00 Andrzej Hajda <a.hajda@samsung.com>:
>> Unsigned expressions cannot be lesser than zero. Presence of comparisons
>> 'unsigned (<|<=|>|>=) 0' often indicates a bug, usually wrong type of variable.
>> The patch beside finding such comparisons tries to eliminate false positives,
>> mainly by bypassing range checks.
>>
>> gcc can detect such comparisons also using -Wtype-limits switch, but it warns
>> also in correct cases, making too much noise.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v6: improved range check detection (according to Julia suggestion)
>> v5: improved range check detection
>> v4: added range check detection, added full check in case value holds a result
>>     of signed function
>> v3: added bool type
>> v2: added --all-includes option
>> ---
>>  .../tests/unsigned_lesser_than_zero.cocci          | 76 ++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>>
>> diff --git a/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>> new file mode 100644
>> index 0000000..b9c7ed8
>> --- /dev/null
>> +++ b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>> @@ -0,0 +1,76 @@
>> +/// Unsigned expressions cannot be lesser than zero. Presence of
>> +/// comparisons 'unsigned (<|<=|>|>=) 0' often indicates a bug,
>> +/// usually wrong type of variable.
>> +///
>> +/// To reduce number of false positives following tests have been added:
>> +/// - parts of range checks are skipped, eg. "if (u < 0 || u > 15) ...",
>> +///   developers prefer to keep such code,
>> +/// - comparisons "<= 0" and "> 0" are performed only on results of
>> +///   signed functions/macros,
> Why common unsigned comparisons with <= 0 are not being detected? I
> think that it misleads the code reading and induces further bugs.
> Just reading "var <= 0" infers that var can receive signed value. The
> be clear the comparison should be against zero only "var == 0" or
> depending of the context "!var".
>

Many developers prefer to use "unsigned <= 0" comparison, as more
descriptive
and less fragile. See for example for the last phrase of Linus email[1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2054063

Regards
Andrzej
