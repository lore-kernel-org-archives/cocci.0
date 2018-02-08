From: devel.fx.lebail@orange.fr (Francois-Xavier Le Bail)
Date: Thu, 8 Feb 2018 15:32:02 +0100
Subject: [Cocci] Not pointer expression
Message-ID: <f33cbd82-389c-77c4-65f9-af15f4eb4ab3@orange.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

expression *e;
define 'e' is a pointer expression.

Is there a way to define 'e' is *not* a pointer expression?
-- 
Francois-Xavier
