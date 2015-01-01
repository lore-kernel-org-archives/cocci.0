From: christof@warlich.name (Christof Warlich)
Date: Fri, 02 Jan 2015 00:50:09 +0100
Subject: [Cocci] adding function declarations
In-Reply-To: <alpine.DEB.2.02.1501012052080.2038@localhost6.localdomain6>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011700110.2060@localhost6.localdomain6>
 <54A59ACD.4050501@warlich.name>
 <alpine.DEB.2.02.1501012052080.2038@localhost6.localdomain6>
Message-ID: <54A5DD31.80408@warlich.name>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

 > Now I'm not sure what is wanted to be done.

Sorry if my last mail caused confusion: I just thought I may simplify 
things by suggesting to avoid expanding the "inline" macro for 
generating the semantic patch at all: Without "inline" being defined as 
a macro, Coccinelle would no see any attributes at all, so that the 
complete task of the semantic patch boils down to converting

static inline <someType> <someFunctionName>(<someParameterList>) {
     <someCode>
}

to

static inline <someType> <someFunctionName>(<someParameterList>);
<someType> <someFunctionName>(<someParameterList>) {
     <someCode>
}

Then, after creating and applying the semantic patch that does the 
conversion described above, the linux build process would do its macro 
magic as usual, causing the preprocessor to do its work, e.g. replacing 
"inline" by "inline __attribute__((always_inline)) 
__attribute__((no_instrument_function))". Doing so would make g++ happy 
as well, as the attributes are now only present in the function's 
declaration instead of the functions definition.
