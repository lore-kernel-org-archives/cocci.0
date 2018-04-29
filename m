From: Robert.Larice@t-online.de (Robert Larice)
Date: Sun, 29 Apr 2018 13:00:40 +0200
Subject: [Cocci] please help me with a "repetition"
Message-ID: <kkefiy2s6f.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

  probably a stupid question,
  I'm failing to match something like this

+  int newvar;
   i++; i++; ... any sequence of only "i++";
+  buckbear(42);

  I don't succeed to express this "maximum length repetition"
    in the mids of those two insertions.

Best Regards,
  Robert
