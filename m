From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 20 Apr 2016 17:26:26 +0100
Subject: [Cocci] Dependencies between spatch hunks
In-Reply-To: <alpine.DEB.2.10.1604201749590.3089@hadrien>
References: <571787F0.7050200@gmail.com>
 <alpine.DEB.2.10.1604201749590.3089@hadrien>
Message-ID: <5717ADB2.1050403@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20/04/16 16:53, Julia Lawall wrote:
> 
> On Wed, 20 Apr 2016, Kieran Bingham wrote:
> 
>> Hi all,
>>
>> I am finding that a rule which matches a part of code, sometimes causes
>> hunks which depend on it to act, and sometimes not to act
>>
>> My spatch is successfully removing and converting hunks that I desire
>> changed, however the requirement became apparent *to not process the
>> file at all* if the variable is used in the probe function, so I added
>> in a dependency on probe_id_unused (established in my previous mail thread).
> 
> I'll check on the rest shortly, but if you really want to not process the
> file at all, just look for the condition in which that is the case, and
> then write a python rule that depends on it, and run Cocci.exit() (not
> sure about the exact syntax - writing an ocaml rule and putting
> Coccilib.exit() will also work).


Thanks Julia,

The following worked for my needs:

@ script:python depends on driver && !probe_id_unused @
@@
print("Probe function uses the ID parameter")
cocci.exit()

However, interestingly - it's not useful if I specify a minimal set of
files on the command line:

Using the command:
spatch --linux-spacing --sp-file patches/i2c-dt.cocci $A $B $C $D
HANDLING: sound/soc/codecs/wm8737.c drivers/staging/iio/light/isl29018.c
drivers/gpio/gpio-pca953x.c ./drivers/rtc/rtc-ds1307.c
Probe function uses the ID parameter
kbingham at CookieMonster:/opt/projects/linux/kbuild-bbb/sources/linux$

appears to stop at the first file (which is expected to stop) without
processing the next files.

However, simply using the '.' target - does appear to iterate through
the entire sources successfully, parsing files it can, and stopping on
files that it should stop on.

Thanks again,

--
Kieran

> julia
> 
>> Therefore, I would expect to be able to set the 'depends on' to be on
>> 'probe_id_unused' for each of the actions, and have actions only taken
>> if the full dependency chain (C4->C1 below) is met.
>>
>> However, I get a non-consistent application of this, where some hunks
>> operate when (I believe) they shouldn't:
>>
>> My full spatch for reference, is at:
>>
>> https://gist.github.com/kbingham/96477177dd20a72b1c2f
>>
>> In essence, it does the following {C}hecks:
>> C1 - of_dev_id_present : Check for a struct of_device_id
>> C2 - dev_id : Check for a struct i2c_device_id
>> C3 - driver : Check and identify the probefunc in the driver structure
>> C4 - probe_id_unused : Establish if the id is used in the probe function
>>
>> Where C4 depends on C3 depends on C2 depends on C1
>>
>> The aim is that if all of the above checks/identifiers are met, it will
>> take the following actions:
>> A rewrite the probe function declaration
>> B re-point the function pointer in the driver structure
>> C remove the i2c_device_id reference
>> D remove the i2c_device_id array
>> E remove the MODULE_DEVICE_TABLE macro
>>
>> For this example, I'll take three files from the kernel source, all of
>> which meet conditions C1 - > C3 (but only F3 meets C4):
>>
>> F1: drivers/gpio/gpio-pca953x.c  : probe id used ( ! C4 )
>> F2: drivers/staging/iio/light/isl29018.c : probe id used ( ! C4 )
>> F3: sound/soc/codecs/wm8737.c : probe id UNUSED ( C4 )
>>
>> If all the actions (A->E) start with @ depends on driver @ (to depend on
>> C3) all the actions complete on these files. (Shown in sequence in the c
>> file)
>>
>> F1 : D E A B C
>> F2 : A D E B C
>> F3 : A D E B C
>>
>> However, if all the actions depend on @ depends on probe_id_unused @
>> (depends on C4), Some actions complete, and some do not!
>>
>> F1 : D E C       (Unexpected behaviour - I expect F1 : <no change>)
>> F2 : D E C       (Unexpected behaviour - I expect F2 : <no change>)
>> F3 : A D E B C   (Expected behaviour)
>>
>> So of course, I want actions D E and C to *not* complete on F1 and F2,
>> but I can't understand why they do not comply with their 'depends'
>> chain. Am I looking at a bug in Coccinelle here or a bug with my
>> interpretation of the depends keyword?
>>
>> Sorry for the long mail, and look forward to any ideas!
>>
>> --
>> Regards
>>
>> Kieran
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>
