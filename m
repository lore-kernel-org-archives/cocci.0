From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Jan 2015 17:02:47 +0100 (CET)
Subject: [Cocci] adding function declarations
In-Reply-To: <54A55D15.5020306@warlich.name>
References: <54A55D15.5020306@warlich.name>
Message-ID: <alpine.DEB.2.02.1501011700110.2060@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 1 Jan 2015, Christof Warlich wrote:

> Hi,
> 
> being absolutely new to Coccinelle, I see that fascinating things can be done
> with it, but I kind of fail to adopt things towards my own needs:
> 
> I'd like to adapt the header files of a huge C project (gcc) so that they may
> alternatively be included by C++ (g++) code. But many of the header files do
> contain numerous inline function definitions of the form
> 
> static inline __attribute__((always_inline)) <someReturnType>
> <someFunctionName>(<someParameters) {
>     <someCode>
> }
> 
> While gcc happily accepts this type of code, g++ complains that specifying
> attributes is not allowed during function definition, but only during
> function declaration. Thus, the fix is straight forward: All these
> occurrences must be replaced by something like
> 
> static inline __attribute__((always_inline)) <someReturnType>
> <someFunctionName>(<someParameters);
> <someReturnType> <someFunctionName>(<someParameters) {
>     <someCode>
> }
> 
> Can anyone give me some guidance on how I can express this as a semantic
> patch?

Unfortunately, there is no way to match against attributes.  But it should 
be possible to add them.  Is the attribute in question always 
__attribute__((always_inline))?  Could it occur that some static inline 
functions don't have this attribute?  In that case would it be OK to add 
the atribute anyway?  Is it necessary to check for an existing function 
declaration, or can one assume that it never exists?

julia
