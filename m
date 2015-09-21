From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 21 Sep 2015 15:34:47 +0200
Subject: [Cocci] [PATCH v3] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55FFFFF4.4000007@users.sourceforge.net>
References: <alpine.DEB.2.02.1509180734350.2064@localhost6.localdomain6>
 <1442831864-25759-1-git-send-email-a.hajda@samsung.com>
 <55FFFFF4.4000007@users.sourceforge.net>
Message-ID: <56000777.6060208@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/21/2015 03:02 PM, SF Markus Elfring wrote:
>> v3: added bool type
> I would appreciate a bit more feedback for my concerns around your
> evolving approach.

Ups, I have missed your email.

> * Reuse of "long int"?
If you mean adding int to 'unsigned long [long]' types, it does not work.
For some reason it works only without adding int after long.

> * Splitting of the suggested SmPL rule so that each source code check
> will be connected with appropriate warning messages.

Personally I prefer one message as it is more compact and
fits quite well in both cases, but I have no strong fillings with separate
message for each case.

>
> Will any more fine-tuning be useful?
Could you elaborate it.

Regards
Andrzej

>
> Regards,
> Markus
>
