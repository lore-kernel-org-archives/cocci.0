From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 10 Jun 2014 07:23:27 +0100 (BST)
Subject: [Cocci] replace waserror/error with goto fail
In-Reply-To: <CAP6exYKm8x7-f-dwvNVYuNw=MZHdsRv391Vj5g03hZvCzxQXuw@mail.gmail.com>
References: <CAP6exYKm8x7-f-dwvNVYuNw=MZHdsRv391Vj5g03hZvCzxQXuw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1406100717381.3267@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 9 Jun 2014, ron minnich wrote:

> I have a lot of code with this sort of thing:
> if (waserror()) {
> ? ? error stuff
> }
>
> if waserror() {
> ? ?more error stuff
> ? ?nexterror() goes to first waserror
> }
>
> if (bad2) error() // goes to second waserror
>
> poperror()
>
> if (bad1) error() // goes to first error

Could you be more concrete?

Coccinelle is unfortunately not very good at arbitrary sequences of
statements.  If the code you are describing is line the code in the Linux
kernel, where you have

if (error)
  A
  return fail;
...
if (error)
  A
  B
  return fail
...
if (error)
  A
  B
  C
  return fail

that you want to convert to:

err3: C
err2: B
err1: A
      return fail

then this would be hard for Coccinelle.  You could somehow make a rule to
pick up each of the statements individually in the error handling code,
but since there is an arbitrary number of them, there would be no way to
be sure to drop them down in the error handling code in the right order.

I had a student who made a tool to do exactly the above transformation.
If this is what you want to do, I can see if he could resurrect the code.

The tool is described in the following paper:

Suman Saha, Julia L. Lawall, Gilles Muller: An approach to improving the
structure of error-handling code in the linux kernel. LCTES 2011: 41-50

julia

> Now, by inspection, one can unwind this stuff but ... any thoughts on
> whether this is doable by spatch??
>
> This could get transformed into:
>
> if (bad2) goto fail2
>
> if (bad1) goto fail1
>
> fail2:?
> ? fail2 stuff
> fail1:?
> ? ?fail1 stuff
>
>
>
> Thanks
>
> ron
>
>
