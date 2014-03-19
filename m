From: bernd@petrovitsch.priv.at (Bernd Petrovitsch)
Date: Wed, 19 Mar 2014 13:02:58 +0100
Subject: [Cocci] [PATCH] Coccicheck: Remove memcpy to struct assignment
	test
In-Reply-To: <1395177092-3023-1-git-send-email-peter.senna@gmail.com>
References: <1395177092-3023-1-git-send-email-peter.senna@gmail.com>
Message-ID: <1395230578.12633.21.camel@thorin>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Die, 2014-03-18 at 22:11 +0100, Peter Senna Tschudin wrote:
> The Coccinelle script scripts/coccinelle/misc/memcpy-assign.cocci look
> for opportunities to replace a call to memcpy by a struct assignment.
> This patch removes memcpy-assign.cocci as it is not clear that this
> convention has an impact on the generated code.

Using struct assignment keeps the type check and is just for this reason
always preferable over memcpy().

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd at petrovitsch.priv.at
                     LUGA : http://www.luga.at
