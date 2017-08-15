From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 15 Aug 2017 15:18:10 -0500
Subject: [Cocci] __init macro and Coccinelle
Message-ID: <d2d75cb0-c297-ba65-d7cd-84ff21e5d409@embeddedor.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello everybody,

I have the following script:

@r@
identifier f_init;
position p;
@@


* __init f_init at p(...)

I want to spot __init functions, but it doesn't seem to work. I get a 
parse error around the __init macro:

around = '__init',
   whole content = * __init f_init at p(...)

I wonder if there is a way to work around that issue?

Thank you
-- 
Gustavo A. R. Silva
