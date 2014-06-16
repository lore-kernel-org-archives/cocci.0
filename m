From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Jun 2014 18:09:35 +0200 (CEST)
Subject: [Cocci] Type change errors
In-Reply-To: <13B51409AF4D26439D6326248B3C48D10266972250F3@lilienthal.MICROPILOT.COM>
References: <13B51409AF4D26439D6326248B3C48D10266972250F3@lilienthal.MICROPILOT.COM>
Message-ID: <alpine.DEB.2.10.1406161758590.3010@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @ rule1 @
>
> identifier i1;
>
> @@
>
> ?
>
> (
>
> - unsigned int i1;
>
> + uint32_t i1;

This is not a good idea, because it is overspecified.  All you want to do
is change the type.  You don't need to specify that the type has to be in
a variable declaration.  Here is what I tried:

@@
typedef uint_32;
@@

-unsigned int
+uint_32

On the code:

int main(unsigned int x) {
  unsigned int y,z;
  return (unsigned int)(y+z);
}

You may have problems with variable declarations that include multiple
variable.  I have been working on that quite a bit recently, and I don't
remember what is the status of that in the current release.  Maybe there
will be a new release soon.

> Catch the bulk of our 32-bit integer usage in declarative statements, but
> it?s obviously going to miss a lot of stuff, including function definitions
> and prototypes. My attempts to use more sophisticated rules, such as
>
> ?
>
> @ rule25 @
>
> identifier i2;
>
> @@
>
> ?
>
> unsigned
>
> (
>
> ? - long i2;
>
> |
>
> ? - int i2;
>
> )
>
> + uint32_t i2;

You can't do this.  You can't put a + on the outside of a disjunction.
The + code has to be repeated in both branches.

> Or
>
> ?
>
> @ rule4 @
>
> identifier fn;
>
> identifier i2;
>
> @@
>
> ?
>
> fn(...
>
> ?? - int i2
>
> ?? + int32_t i2
>
> ? ...)

Two problems here.  First, the elements of a parameter list need to be
separated by commas.  This includes ...  Second, a pattern has to be a
complete term.  The outer part of this looks like a function call
(function name, open and close parentheses, etc), but then the types mean
that it can't be that.  To match a function definition, it needs a body,
ie { ... }.  Normally, if you change the header of a definition, it will
change any prototypes that it finds at the same time.  But if the
prototype is in a header file, and it doesn't find the header file when it
is working on the C file, the prototype won't get transformed.

But anyway, if you just make a rule on types, and not on contexts of
types, the issue becomes irrelevant.

> Result in a mysterious (and unhelpful) ?minus: parse error...? Even trying
> to omit the semicolons does not work. The very basic:

Normally when you get a parse error it should tell you the line number and
offset in the line of the problem.  But it may take some getting used to
the grammar to know what is being pointed at.

> @ rule3 @
>
> identifier i2;
>
> @@
>
> ?
>
> ?? - int i2
>
> ?? + int32_t i2
>
> ?
>
> ?
>
> Also throws a ?minus parse error...?. But from what I understand, the
> semicolon should not be a necessary component to Coccinelle syntax.

The semicolon is necessary.  The semicolon is not necessary on eg

x = 12

because in C x = 12 is an expression.  x = 12; is a statement that
consists of a single expression, which is x = 12.  This is why you can
write eg if (x = foo()) ...  But int i2 is not a complete anything.  It
needs a semicolon.

julia
