From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 4 Jul 2017 20:17:36 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!afea88a820c9c853667fab8a120e0e62e64bc1c9aacab0e42f4149cedda4906e7b85ddc1f742afe16ea78098b42a61f6!@mailstronghold-3.zmailcloud.com>
References: <WM!cc508729d042cf12207adee814670b88c105ae73cdaf601fdeb9c3e26fa32e7df0d4d49f847a216810550421de0d8de6!@mailstronghold-3.zmailcloud.com>
 <20170704162732.urhtl54j3gbj3myh@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041837300.11588@hadrien>
 <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
 <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041858400.11588@hadrien>
 <WM!6445a14b41a047e62e6e93d9a0da969d5ea2daf83555655349684d54f3d26f5ca8795d092a053f4ee93c2a22f577a788!@mailstronghold-1.zmailcloud.com>
 <20170704174632.v7ibsesdtquktbjs@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041948510.3327@hadrien>
 <WM!afea88a820c9c853667fab8a120e0e62e64bc1c9aacab0e42f4149cedda4906e7b85ddc1f742afe16ea78098b42a61f6!@mailstronghold-3.zmailcloud.com>
Message-ID: <20170704191736.rcghven7t3ol5ih3@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 04, 2017 at 07:53:13PM +0200, Julia Lawall wrote:
>> Looking at some of the code (well, comments rather), coccinelle is
>> building a CTL formula and a state machine for the C file and tries to
>> find the states where it matches? Is that correct?
> 
> Yes, this is correct.
> 
>> Does it try to compress the state machine based on the predicates
>> involved? BDDs tend to be rather helpful with CTL model checking. Not
>> sure how useful that is, depending on the information that needs to be
>> extracted (and I've not touched model checking in ages).
> 
> No, we don't do that.  Basically, the graph itself is pretty small, but
> the problem is all of the possible variable bindings.  Our reasoning was
> that BDDs would not be helpful.

So the variable bindings are not expressible as predicates (which is
what I would have expected to explode the state space)? I guess not
since I have dealt with files take a lot of time to process and spatch
doesn't actually consume that much more space, where CTL model-checking
complexity is linear to the graph size. So I guess that answers my
question.

>> Sorry if this is completely wrong.
>>
>> I vaguely remember seeing something like this somewhere, but can't find
>> it anymore. That might simplify the three-pronged construction I use
>> into a single patch hunk like the below. Is there a construction like
>> that available or have I just dreamed that up?
>>
>> @@
>> (stuff here also contains format1, format2, args_before and others as
>> usual)
>> identifier merged : python merge_formats(format1, format2, args_before);
>> @@
>>
>> -snprintf( buf, E, format1, args );
>> -Debug( L, format2, args_before, buf, args_after );
>> +Debug( L, merged, args_before, args, args_after );
> 
> You made it up :)  Currently, the only thing you can do with python on the
> fly like this is write predicates, not create variable values.  The exact
> syntax is, eg

Shame, maybe a feature request? Thing is that while the following is a
useful idiom to generate new code with python where coccinelle can't
(yet) generate it itself, it does seem unnecessarily complex:

@a@
bindings
@@
a at p1
b at p2
c at p3

@script:python a_process@
read << a.bindings
exported;
@@
code

@a_change@
a.bindings
identifier a_process.exported;
@@
a at p1
-b at p2
+new(stuff, exported)
-c@p3

where with a few restrictions (e.g. we don't set up cyclic dependencies,
what the python code is allowed to do, ...) this would be able to
express the same and make things easier:

@@
bindings
identifier x : script:python(some bindings, even from this rule) { code }
@@
a
-b
+new(stuff, x)
-c

> identifier x : script:python(...) { ... }
> 
> The first ... is any inherited metavariables that the script code needs,
> but variables defined in the same rule are not allowed.  The second ...
> needs to look like C code.  Typically, it would be a function call, and
> then you would define the function in the
> 
> @initialize:python@
> @@
> 
> code at the beginning of the script, where you can put whatever python
> code you want.

All in all, I'm getting close to getting a testable patch, though :)
Thanks for the great support!

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
