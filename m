From: rminnich@gmail.com (ron minnich)
Date: Mon, 9 Jun 2014 15:04:19 -0700
Subject: [Cocci] replace waserror/error with goto fail
Message-ID: <CAP6exYKm8x7-f-dwvNVYuNw=MZHdsRv391Vj5g03hZvCzxQXuw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have a lot of code with this sort of thing:

if (waserror()) {
    error stuff
}

if waserror() {
   more error stuff
   nexterror() goes to first waserror
}

if (bad2) error() // goes to second waserror

poperror()

if (bad1) error() // goes to first error

Now, by inspection, one can unwind this stuff but ... any thoughts on
whether this is doable by spatch?

This could get transformed into:

if (bad2) goto fail2

if (bad1) goto fail1

fail2:
  fail2 stuff
fail1:
   fail1 stuff



Thanks

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140609/e55151d9/attachment.html>
