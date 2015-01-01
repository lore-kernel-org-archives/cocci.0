From: christof@warlich.name (Christof Warlich)
Date: Thu, 01 Jan 2015 15:43:33 +0100
Subject: [Cocci] adding function declarations
Message-ID: <54A55D15.5020306@warlich.name>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

being absolutely new to Coccinelle, I see that fascinating things can be 
done with it, but I kind of fail to adopt things towards my own needs:

I'd like to adapt the header files of a huge C project (gcc) so that 
they may alternatively be included by C++ (g++) code. But many of the 
header files do contain numerous inline function definitions of the form

static inline __attribute__((always_inline)) <someReturnType> 
<someFunctionName>(<someParameters) {
     <someCode>
}

While gcc happily accepts this type of code, g++ complains that 
specifying attributes is not allowed during function definition, but 
only during function declaration. Thus, the fix is straight forward: All 
these occurrences must be replaced by something like

static inline __attribute__((always_inline)) <someReturnType> 
<someFunctionName>(<someParameters);
<someReturnType> <someFunctionName>(<someParameters) {
     <someCode>
}

Can anyone give me some guidance on how I can express this as a semantic 
patch?

Thanks for any help,

Chris
