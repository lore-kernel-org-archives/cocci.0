From: rminnich@gmail.com (ron minnich)
Date: Fri, 30 Aug 2013 20:39:17 -0700
Subject: [Cocci] very simple transformations
Message-ID: <CAP6exYKho8Ano_a82RFj=EzEK6Zfk=5Kz1=SJfomF77CDUKoag@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've got a file with the following sorts of things

void f(uint x)
{
  uint z;
}

I'd like to transform all instances of uint to unsigned int. Doable
with coccinnelle?

Also:
IPhdr x;
needs to become
struct iphdr x;
in all parameters and declarations. Also likely trivial, I can't seem
to get anything to work.

Now a really harder one:
Plan 9 C to C
I have things like
void x(char *, int, int i)
{
...
}

The unnamed params are how we indicate in plan 9 that the parameter is
unused. But coccinnelle throws an error, as it's not really valid. Any
thoughts on this one?

Thanks in advance.

ron
