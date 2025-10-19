Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B682CCD184
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Nqezl9/YCfUYZ35vYE9hNDhPrcTb/B+JN9t5V3h5Vz8=;
  b=nAQXFhCxndS1yXnzTxM0EujAd92gwZMxK//L7YAOWe1bed4uvaYOVJhS
   9Gu4Jz8riH7LB/1jtYSVtfY4FUcZ9tIEKBtqG2Aaet5LiFSDXaE034Tl9
   47tFQoeEfMHvw5XKVDICQonzHAhiy+/rKdyT3VcFV18bDfAUA+LM/dlMR
   w=;
X-CSE-ConnectionGUID: b+hCJI5+SjuNC9o4BXX0YQ==
X-CSE-MsgGUID: v2OnoIUvT1iYInWo75Mucw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245011479"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:00:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26855E0264; Sun, 19 Oct 2025 16:00:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6EE0BE0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:00:38 +0200 (CEST)
X-CSE-ConnectionGUID: aUlT9An+TSSH1+Cq+D0lJw==
X-CSE-MsgGUID: Roohe5DWSS6wudUvIq0/oA==
IronPort-SDR: 68f4ef06_hjqr4SkuEFALv9VOPOYT5ZvN0Vrn16oe5nMJTSSfiyVmoCf
 JAWBHJ5AkuGxkNTw8HyIhUUMYge9WUVHQpl6beg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvCABy7vRogAwR49RagQmBUIJAZSNYMwQLSYRVj1KGX?=
 =?us-ascii?q?4c8kE6DUgIPAQMBDU4BAgQBAQMEggyPQgIeBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGIC8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHbR0BAREnNAImAnMBAYJ+giMBBhABAzYHrRqBMhNuggwBAQaCa?=
 =?us-ascii?q?dd2HywiWYFkCYEcLoVtgkoaAQVuihgPgVVEgTwLgkAHhX+DDoJpgiaBDoYuk?=
 =?us-ascii?q?S2BShwDWSwBVRMXCwcFgWMDgQtuMh2BJ0Eccz1Xg0khaA8GgRODVIlqD4ZCA?=
 =?us-ascii?q?gELbT03CQsbBj2TOIIIbIEVgUyUMSizATQHgjiBZwWBXwyJCJZkBhMvl1IOB?=
 =?us-ascii?q?pMFmQajaIVZgX4kgVwzGiSDNk8DGQ+NeAE0FoQRxlpBNTwCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 Qzw
IronPort-HdrOrdr: A9a23:vIDE3qwW7n6QeekAx2v6KrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3A2PyNI2gFfukfrAFZdHlT6G5w1TJue0DZ8Cb5JQy?=
 =?us-ascii?q?EMl1JEf6+UBy8oKdGjJ87?=
X-Talos-MUID: 9a23:Il8wqAsiTwu2bFBJbs2nvjZlNMo1z5uVMx4SjJk7peidbWt3EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245011466"
X-MGA-submission: =?us-ascii?q?MDFK6Wc5UNw/GVpP9aNUiW+cvV/ybbebz2l24+?=
 =?us-ascii?q?sWeaHCYQS9omCK2Uk1iEbiuH4adYbeTrVhcYziaWkZadVeTZ61SWE6kX?=
 =?us-ascii?q?cfmUgsyl4xcRi+gEXG45fHG54611Q54MYIk0Wy64xLwJMQnm0rHppcOa?=
 =?us-ascii?q?zj9yNytgW/y+ZevGw+9AZt8g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:00:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760882437; x=1761487237; i=markus.elfring@web.de;
	bh=Nqezl9/YCfUYZ35vYE9hNDhPrcTb/B+JN9t5V3h5Vz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XTGdaJyNorRlrlHF6cSFLgSVhEr8ThFgotG0ABUNJwEqnmta7WTocaeechgyOh5Y
	 EU8zmvm4vL02IGloa9YloTQDZNdwO8cICO0g2TdZknQQqd7xVBP8MSvRnDFrhGUSi
	 YfOZw78UxEjqpqXtC9lBx1G4/qOdVQTNrEuVkG/tHyDY27nuVRFyYbrh3q4hNofVE
	 QbQf6XtdeMa+mQ/tX6TtsUehA5qgoslOeBbNrEvK0mrbKmCpvLBex2jg8xcxmMsRN
	 i3XOsdYIwOefHSS6HHHrQ8jgjiNZTBrFphuiZvTa3BLFC6EU8AVx858XKjag7SnLh
	 LfqdneECnSAN1Xv0jg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1vAkwW0Rlp-00BL2t for
 <cocci@inria.fr>; Sun, 19 Oct 2025 16:00:37 +0200
Message-ID: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
Date: Sun, 19 Oct 2025 16:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dTzIG4VcwrAlcH2juaKa2A0+Brm8bYO3/nNe9aYp7uuVJd4Be+K
 t70ewUHNeEdfaeZjLaz97vloMCKxXaJvJ4mhnJxH888LDFs5swzS61UembmnPuH5eQO8mfE
 3dT4rjKFBqZxfrWKIvMjn8oPlzvLWz2QqwvfmIc8fXYNqfJqOiDfuxYH9mugJ9z7zNqYfFs
 yIuoOE4NivMHyJRu+go3Q==
UI-OutboundReport: notjunk:1;M01:P0:/ond2DQs8e0=;CsGVumxRN8bKscID0lPICUEbMwU
 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
 4SDhvSPZycYJCI2agbFsR9PYd5zC5mbyWY8=
Subject: [cocci] Analysis challenges with SmPL for pass-through functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3076
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/4afdfd37-3177-4480-9648-ab0d7f59097c%40web.de>

Hello,

I am curious if further developers will become interested to discuss techn=
ical
details like the following (in combination with the software =E2=80=9CCocc=
inelle 1.3.0=E2=80=9D).

Another source file example:
#include <string.h>

void my_test_copy(void)
{
 char text[123];
 char* target =3D strcpy(text, "Hello!");
 target =3D strcpy(target, "Bye");
}


A)
SmPL script variant:
@display@
constant char[] input;
identifier x, y;
@@
*y =3D strcpy(x, input)

Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
show_selected_strcpy_calls.cocci test-copy_literal_to_buffer2.c
=E2=80=A6
@@ -3,6 +3,4 @@
 void my_test_copy(void)
 {
  char text[123];
- char* target =3D strcpy(text, "Hello!");
- target =3D strcpy(target, "Bye");
 }


B)
SmPL script variant:
@display2@
constant char[] literal;
identifier i;
@@
*i =3D strcpy(i, literal)

Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
show_selected_strcpy_calls2.cocci test-copy_literal_to_buffer2.c
=E2=80=A6
@@ -4,5 +4,4 @@ void my_test_copy(void)
 {
  char text[123];
  char* target =3D strcpy(text, "Hello!");
- target =3D strcpy(target, "Bye");
 }


The variable definition was not matched by the second source code search a=
pproach
because the used identifiers are obviously different there.
This aspect did not hinder an additional match by the first source code se=
arch approach
according to another assignment for the variable =E2=80=9Ctarget=E2=80=9D =
while the same identifier
was found by two metavariables.

Will further clarifications become more interesting for corresponding case=
 distinctions?

Regards,
Markus
