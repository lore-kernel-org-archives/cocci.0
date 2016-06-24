From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 23 Jun 2016 18:38:48 -0700
Subject: [Cocci] Matching stack addresses passed to a function?
Message-ID: <CALCETrVprCY9uRtm4EAtx9DYupJWg_exJRrpZWj=6Ja7rmFLhw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all-

I'm trying to see if I've found all sg_init_one misuses.  Is there a
way to write a rule that will match obvious code paths that pass a
stack address into sg_init_one?  Basically, I want to match:

int foo;
sg_init_one(..., &foo, ...);

and:

int foo[10];
sg_init_one(..., foo, ...);

but not:

void whatever(void *ptr, ...)
{
  sg_init_one(..., ptr, ...);
}

Is there some way to write a metavariable that refers to a value on
the stack?  Or can I somehow cleanly match an actual declaration
followed by a use of the declared variable?

Thanks,
Andy
