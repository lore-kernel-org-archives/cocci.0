From: christof@warlich.name (Christof Warlich)
Date: Thu, 01 Jan 2015 20:06:53 +0100
Subject: [Cocci] adding function declarations
In-Reply-To: <alpine.DEB.2.02.1501011700110.2060@localhost6.localdomain6>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011700110.2060@localhost6.localdomain6>
Message-ID: <54A59ACD.4050501@warlich.name>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Wow - that's been a really fast response :-)

Well, the "huge C project" I talked about is the linux kernel, or more 
precisely, its header files:
Having a few days off, I was curious to see how much effort it may take 
to allow writing modules in C++.

With respect to the static inline functions, it looks like there are no 
already existing function declaration that needs to be checked for, and 
the functions
are actually simply defined along the lines

static inline <someReturnType> <someFunctionName>(<someParameters) { 
<someCode> }

but "inline" is a macro which is defined as

#define inline inline __attribute__((always_inline)) notrace

or

#define inline inline notrace

depending on the kernel configuration, with notrace defined as

#define notrace __attribute__((no_instrument_function))

Thus, it should be possible to let Coccinelle see only the inline 
keyword, without the additional hassle that may be introduced by attributes.

I have some appointment right now, but I'll definitely come back 
tomorrow morning. Thanks a lot for looking into this so far!

Cheers,

Chris

Am 01.01.2015 um 17:02 schrieb Julia Lawall:
> On Thu, 1 Jan 2015, Christof Warlich wrote:
>
>> Hi,
>>
>> being absolutely new to Coccinelle, I see that fascinating things can be done
>> with it, but I kind of fail to adopt things towards my own needs:
>>
>> I'd like to adapt the header files of a huge C project (gcc) so that they may
>> alternatively be included by C++ (g++) code. But many of the header files do
>> contain numerous inline function definitions of the form
>>
>> static inline __attribute__((always_inline)) <someReturnType>
>> <someFunctionName>(<someParameters) {
>>      <someCode>
>> }
>>
>> While gcc happily accepts this type of code, g++ complains that specifying
>> attributes is not allowed during function definition, but only during
>> function declaration. Thus, the fix is straight forward: All these
>> occurrences must be replaced by something like
>>
>> static inline __attribute__((always_inline)) <someReturnType>
>> <someFunctionName>(<someParameters);
>> <someReturnType> <someFunctionName>(<someParameters) {
>>      <someCode>
>> }
>>
>> Can anyone give me some guidance on how I can express this as a semantic
>> patch?
> Unfortunately, there is no way to match against attributes.  But it should
> be possible to add them.  Is the attribute in question always
> __attribute__((always_inline))?  Could it occur that some static inline
> functions don't have this attribute?  In that case would it be OK to add
> the atribute anyway?  Is it necessary to check for an existing function
> declaration, or can one assume that it never exists?
>
> julia
