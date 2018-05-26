From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 May 2018 22:33:36 +0200
Subject: [Cocci] Evolution around profiling of SmPL script execution
Message-ID: <595d32bf-e506-614a-f1d1-3295a0322647@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

The Coccinelle software supports profiling for the execution of SmPL scripts
to some degree.
I find the corresponding description improvable for the provided data.

1. I would find an other separation for the available columns nicer.

2. I suggest to add a column ?area? so that the measured data processing
   can be distinguished better.
   How should the execution of each SmPL rule be identified there?

3. The output of measurement units could be occasionally omitted.


Will the display become more configurable for these software profiling results?

Regards,
Markus
