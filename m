From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 22 Nov 2016 14:52:32 +0100
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <alpine.DEB.2.10.1611221430450.31331@hadrien>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
 <alpine.DEB.2.10.1611221430450.31331@hadrien>
Message-ID: <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 11/22/2016 02:33 PM, Julia Lawall wrote:
> 
> 
> On Tue, 22 Nov 2016, Michael Stefaniuc wrote:
> 
>> Hello,
>>
>> I have to have 3 rules to remove a cast. The rules are basically
>> identical, they just differ by the type of an expression. That type is
>> inherited from different rules that aren't matching at the same time.
>>
>> Now I wanted to use positions to eliminate false positives rather than
>> duplicating that code, but that doesn't work. Using the position in the
>> second rule will generate an error:
>> meta: semantic error: position cannot be inherited over modifications: p
>>
>> Though that doesn't makes sense, as the position is never modified, only
>> all the other positions not matching are modified.
>> Here are the relevant chunks:
>>
>> @ disable drop_cast @
>> type find.To;
>> type T;
>> To *obj;
>> position p != cast_good.p;
>> @@
>> - (T)
>>        (obj at p)
>>
>>
>> @ disable drop_cast @
>> type find2.To;
>> type T;
>> To *obj;
>> position p != cast_good.p;
>> @@
>> - (T)
>>        (obj at p)
> 
> What gets modified is the file, or at least the function, so you can't
> rely on the positions being meaningful once the code has been changed.
Ok, I have seen the positions just as an anchor and as that respective
code is never modified the position shouldn't change.

> I think you could use a disjunction to make just one rule, to avoid the
> problem.
Yeah, but I have to add the disjunction to all 3 functions. That's what
I did initially but that doesn't feels right. But if that's the only
workable solution I'll go back to that.

> You can also put a set of possible types for obj ({type1, type2, ...}) and
> put the whole thing into one line.
That doesn't work, I have tried it before:

@@
{r1.T, r2.T} obj;
@@

That only matches when both r1.T and r2.T are defined. That kinda feels
odd but probably is easier to implement as all inherited variables need
to be bound. I have quiet a few duplicated rules across multiple scripts
due to that.

thanks
bye
	michael
