From: geyslan@gmail.com (Geyslan G. Bem)
Date: Sun, 6 Dec 2015 10:13:46 -0300
Subject: [Cocci] [RFC BUG] coccinelle: use_after_iter parse error
In-Reply-To: <CAGG-pUSh7ajgmcZzhqCatG9iExkW541gBhHmfpnL_UNcNpOidw@mail.gmail.com>
References: <CAGG-pUSh7ajgmcZzhqCatG9iExkW541gBhHmfpnL_UNcNpOidw@mail.gmail.com>
Message-ID: <CAGG-pUSEKCzAtKdVnMp6mvzMRo5_49HnMcMj+wMCC+aFbU7p4w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2015-12-06 10:09 GMT-03:00 Geyslan G. Bem <geyslan@gmail.com>:
> Hi maintainers,
>
> I'm having these error output using coccinelle.

Sorry, gmail and its ctrl+enter shortcut. :/

geyslan at hb ~/Projects/linux $ make coccicheck V=2 M=drivers/usb/host/
-j4 > cocciout
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")
Fatal error: exception Failure("minus: parse error: \n = File
\"./scripts/coccinelle/iterators/use_after_iter.cocci\", line 126,
column 0,  charpos = 3561\n    around = '&', whole content =
&c->member\n")

sizeof(<+...c...+>)
|
&c->member  // Line 126
|
c = E

geyslan at hb ~/Projects/linux $ spatch --version
spatch version 1.0.4 with Python support and with PCRE support


>
>
> --
> Regards,
>
> Geyslan G. Bem
> hackingbits.com



-- 
Regards,

Geyslan G. Bem
hackingbits.com
