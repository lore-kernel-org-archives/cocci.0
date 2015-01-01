From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Jan 2015 20:54:38 +0100 (CET)
Subject: [Cocci] adding function declarations
In-Reply-To: <54A59ACD.4050501@warlich.name>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011700110.2060@localhost6.localdomain6>
 <54A59ACD.4050501@warlich.name>
Message-ID: <alpine.DEB.2.02.1501012052080.2038@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 1 Jan 2015, Christof Warlich wrote:

> Wow - that's been a really fast response :-)
> 
> Well, the "huge C project" I talked about is the linux kernel, or more
> precisely, its header files:
> Having a few days off, I was curious to see how much effort it may take to
> allow writing modules in C++.
> 
> With respect to the static inline functions, it looks like there are no
> already existing function declaration that needs to be checked for, and the
> functions
> are actually simply defined along the lines
> 
> static inline <someReturnType> <someFunctionName>(<someParameters) {
> <someCode> }
> 
> but "inline" is a macro which is defined as
> 
> #define inline inline __attribute__((always_inline)) notrace
> 
> or
> 
> #define inline inline notrace
> 
> depending on the kernel configuration, with notrace defined as
> 
> #define notrace __attribute__((no_instrument_function))
> 
> Thus, it should be possible to let Coccinelle see only the inline keyword,
> without the additional hassle that may be introduced by attributes.
> 
> I have some appointment right now, but I'll definitely come back tomorrow
> morning. Thanks a lot for looking into this so far!

Now I'm not sure what is wanted to be done.  It seems like you would want 
to choose the configuration options that give you

#define inline inline notrace

because even if Coccinelle makes a prototype with the right arribute 
declaration, the other macro definition is still going to expand to 
something that the compiler doesn't like.  If there is a way to get 
notrace to expand to nothing, then it seems like everything would be OK?

julia
