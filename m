From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Fri, 21 Apr 2017 17:11:16 +0200
Subject: [Cocci] new to cocci, help needed
In-Reply-To: <f489d08f-793d-6df2-791e-570c33bf25a6@schleiser.de>
References: <ba1249bd-36ab-a819-34b8-186d84a4ec49@schleiser.de>
 <alpine.DEB.2.20.1704211109020.3038@hadrien>
 <e59dc5e9-df34-27e8-da04-c5590c00edef@schleiser.de>
 <alpine.DEB.2.20.1704211526390.3038@hadrien>
 <f489d08f-793d-6df2-791e-570c33bf25a6@schleiser.de>
Message-ID: <fef9bec0-99a6-0a40-871a-01eb7972cc61@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 04/21/2017 03:41 PM, Kaspar Schleiser wrote:
> 
> 
> On 04/21/2017 03:27 PM, Julia Lawall wrote:
>>
>>
>> On Fri, 21 Apr 2017, Kaspar Schleiser wrote:
>>
>>>
>>>
>>> On 04/21/2017 11:10 AM, Julia Lawall wrote:
>>>>
>>>>
>>>> On Fri, 21 Apr 2017, Kaspar Schleiser wrote:
>>>>
>>>>> Hello all,
>>>>>
>>>>> I'm just beginning to write my own semantic patches, and I'm having a
>>>>> little trouble getting the hang of it.
>>>>>
>>>>> Currently I'm trying to unify all calls to a function named "f" taking a
>>>>> pointer to a variable and the variable's size as arguments, which I want
>>>>> to deduce using sizeof:
>>>>>
>>>>> f(..., &var, sizeof(var))
>>>>>
>>>>>
>>>>> My initial approach looks similar to this:
>>>>>
>>>>> @@
>>>>> expression E1, E2;
>>>>> @@
>>>>>
>>>>> f(...,*E1,
>>>>> - E2,
>>>>> + sizeof(E1))
>>>>>
>>>>> ... but this doesn't find e.g., "f(a, b, &test, whatever);".
>>>>>
>>>>> What am I doing wrong?
>>>>
>>>> Your pattern has *E1, but you are hoping to match &E1.
>>>>
>>>> If you mean that E1 should be a random pointer-typed expression, then that
>>>> constraint should go in the metavariable list, eg
>>>>
>>>> expression *E1;
>>>
>>> That brings me one step further, but now I have "*&", e.g.,
>>>
>>> - f(a,b,&E,whatever)
>>> + f(a,b,&E,sizeof(*&E))
>>
>> I think you would want sizeof(E)?
I normally use a second rule to clean that one up
@@
expression E;
@@
- *&
    E

bye
	 michael
