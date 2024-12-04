Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD392E7716B
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XQ14n68u6NWtkLtFk55vj2BSg1QDUEtC5VZLEqzTMpw=;
  b=YruBEWEuoTmg5FpUxw6kPPMt9GlcWf4shjM26YqtfjetoIBoE+zJuunu
   /mr0Hk+810td+pIIV54HHs9EoXQdyDyt2L/mCEFCjNcyaX7BABF0Di+lZ
   57qfCFaMToJ6hroCKiLtd5VonAwppBjfZUvGn5liVlH5rCFLuGtP3lQgo
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,207,1728943200"; 
   d="scan'208";a="197317798"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 13:13:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F1ECE013D; Wed,  4 Dec 2024 13:13:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B870E00B6
	for <cocci@sympa.inria.fr>; Wed,  4 Dec 2024 13:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:subject:mime-version:
   content-transfer-encoding;
  bh=XQ14n68u6NWtkLtFk55vj2BSg1QDUEtC5VZLEqzTMpw=;
  b=rNW5zEXd0ULFsG7YM9xAY4LQVKzzyrc9Z2UHSyqbnLdm5xJZ/kDH13PG
   /nvkCRoUikS6Rmp5lvs4QsqMzfXCauVfNZou8xO/4uXgs7a6B2s8KvArO
   hBUq/psAfogTAXj/492Tmk2lNNUfnoTLkJBU1UlJytn9NgO+Udn1fDjBb
   o=;
X-IronPort-AV: E=Sophos;i="6.12,207,1728943200"; 
   d="scan'208";a="197317781"
X-MGA-submission: =?us-ascii?q?MDGwF5VMnKYlrwcMstMUTqqTHydvvbfkF4uyhB?=
 =?us-ascii?q?3yRLW7yMuYhqp2wUPahWWrQgIijwB/mCArHzb/JXcYH9fXdSDJEEMdjr?=
 =?us-ascii?q?fZxN0BZ5PxElPRUduiF2UuqQKsBkCynQ4Ip/qPshB7xkcnYd/Oaam3J+?=
 =?us-ascii?q?l06649O6+RjieBzdOpMV0eVA=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 13:13:34 +0100
Date: Wed, 4 Dec 2024 13:13:34 +0100 (CET)
From: Ella Ma <xutong.ma@inria.fr>
To: cocci@inria.fr
Message-ID: <820693222.25218599.1733314414146.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.93.82.7]
X-Mailer: Zimbra 10.0.9_GA_4654 (ZimbraWebClient - GC131 (Linux)/10.0.9_GA_4654)
Thread-Index: K30DbI1g5UkL5rwnijMmf2NaYVEfMw==
Thread-Topic: Fix on bash completion script for `_spatch not found` issue
Subject: [cocci] RFC: Fix on bash completion script for `_spatch not found`
 issue
Reply-To: Ella Ma <xutong.ma@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2146
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/820693222.25218599.1733314414146.JavaMail.zimbra%40inria.fr>

Hi all,

In another email, Victor Gambier mentioned that

>> I also noticed weird things around bash autocompletion. Regardless of
>> whether or not the autocompletion finds any matches, if your command
>> started with "spatch", the line "bash: completion: function `_spatch'
>> not found" will show up. I think that could be related to the standard
>> stream weirdness. To be more precise:
>>
>> $ spatch /h
>> + [TAB]
>> will transform into:
>>
>> $ spatch /hbash: completion: function `_spatch' not found
>> $ spatch /home/

So I checked the bash completion script for spatch (scripts/spatch.bash_completion)
and found this

```scripts/spatch.bash_completion
...
have spatch &&
_spatch() { ... } # function body omitted for simplicity

complete -F _spatch ... spatch
...
```

The `have` command will check whether the argument is an executable in PATH
or a function defined in the current context.
In our case, the `have` command checks whether `spatch` command is available.
If not, the complete function `_spatch` will not be defined.

But, no matter whether the `have` check passes or not,
function `_spatch` will always be assigned for the completion of spatch.
So, if it is not defined, we will encounter the problem we observed now.

I think this may be due to the order of
(1) adding the path of spatch to PATH (the opam switch dir or other prefixes), and
(2) loading bash completion files.

I did not dig deeply into the order which happens first.
But I believe its the problem of PATH variable according to what we have observed now.
So, I suggest removing the `have` check protecting the definition of function _spatch.
I propose this solution because all the complete scripts in the system,
i.e. /etc/bash_completion.d and /usr/share/bash-completion/completions,
do not perform the `have` check;
and if spatch is installed to opam switch root, the `have` check may never pass,
as the opam paths are appended to the end of the $HOME/.bashrc file.


What do you think? Any suggestions are welcome.

ella


P.S.: Suggested patch:

```
diff --git a/scripts/spatch.bash_completion b/scripts/spatch.bash_completion
index ae217af9e..3ff48d9c7 100644
--- a/scripts/spatch.bash_completion
+++ b/scripts/spatch.bash_completion
@@ -34,7 +34,6 @@ __spatchcomp_1 ()
         done
 }
 
-have spatch &&
 _spatch()
 {
     local cur prev xspec
```
