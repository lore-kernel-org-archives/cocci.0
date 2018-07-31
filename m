From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 31 Jul 2018 18:12:35 +0200
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
References: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
Message-ID: <2efc7722-b133-79e6-df1e-7b489213c5fd@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Attached.

I have taken this transformation approach as an opportunity to take another look
at implementation details for further software development considerations.


@rule1@
expression x;
expression list y;
@@
-DBG_PRINTF
+NV_PRINTF
          (
-          (x),
           y);


You repeated additions of identifiers in a few SmPL rules. I would find it nicer
to combine corresponding deletions into SmPL disjunctions (when you would like
to avoid to fiddle with regular expressions as SmPL constraints).


@A depends on rule1@
@@
 NV_PRINTF(...,
-          \(DBG_LEVEL_INFO \| DEBUGLEVEL_TRACEINFO \| DBG_LEVEL_SETUPINFO \| DEBUGLEVEL_SETUPINFO\)
+          LEVEL_INFO
           , ...);

@B depends on rule1@
@@
 NV_PRINTF(...,
-          \(DBG_LEVEL_USERERRORS \| DEBUGLEVEL_USERERRORS\)
+          LEVEL_NOTICE
           , ...);

@C depends on rule1@
@@
 NV_PRINTF(...,
-          \(DBG_LEVEL_WARNINGS \| DEBUGLEVEL_WARNINGS\)
+          LEVEL_WARNING
           , ...);

@D depends on rule1@
@@
 NV_PRINTF(...,
-          \(DBG_LEVEL_ERRORS \| DEBUGLEVEL_ERRORS\)
+          LEVEL_ERROR
           , ...);


Do you find such SmPL code adjustments useful?

Regards,
Markus
