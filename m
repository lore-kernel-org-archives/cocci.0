From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 22 Nov 2016 13:46:26 +0100
Subject: [Cocci] Negated Positions and Modifications
Message-ID: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have to have 3 rules to remove a cast. The rules are basically
identical, they just differ by the type of an expression. That type is
inherited from different rules that aren't matching at the same time.

Now I wanted to use positions to eliminate false positives rather than
duplicating that code, but that doesn't work. Using the position in the
second rule will generate an error:
meta: semantic error: position cannot be inherited over modifications: p

Though that doesn't makes sense, as the position is never modified, only
all the other positions not matching are modified.
Here are the relevant chunks:

@ disable drop_cast @
type find.To;
type T;
To *obj;
position p != cast_good.p;
@@
- (T)
       (obj at p)


@ disable drop_cast @
type find2.To;
type T;
To *obj;
position p != cast_good.p;
@@
- (T)
       (obj at p)


thanks
bye
	michael
