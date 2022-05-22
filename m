Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFCDC433F5
	for <cocci@archiver.kernel.org>; Sun, 22 May 2022 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gqXQ/CNqBWjuJOK1ODbRk25dA5CfHZsNDfnrWrLZEB4=;
  b=RU6EDDH1uJgwPwzKZVKCDrQGOmSLRcO1ofl1IPxM6aP3HBDR6S7LJbGb
   SpRmGEFNAhTgvqcwBxBo1HXj9ITDJ6k8A9JI2+FfaN6LxGorzvIebPMke
   PB8AU9ilcx8xLVQmkXfaDZo763Qrt2GIlt/6jBE6iCJU9T38/Y3bvtsas
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,243,1647298800"; 
   d="scan'208";a="37496842"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2022 08:05:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C63DE4374; Sun, 22 May 2022 08:05:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C2D4CE0094
	for <cocci@sympa.inria.fr>; Sun, 22 May 2022 08:05:27 +0200 (CEST)
IronPort-SDR: Cw+n3QcBTEWPo5jcNq6ZoqccGzpEWtiHZi+xCFI3WJtSmgkjSfo2BnhubpfONv+8wd6PMhR3Go
 Lj1xkfMvkxmjKJBlsbueFoK7TcsGrN39ep5/TScYgaIFglwQw7/7PZ0VeblrVCoGL+2hDZQOXs
 SkQ/KdZf0a3zYXscnBHVW4jA3Hb/PH6Sm8NNjPWVY81D6suDRClkeDcfywcuAt0DQGwGUbRmql
 YOFyazEOTJCaFHmzegSXNwyksOIYfctyH1rQKGcvLiFxNzH//CF7PtnFm0NjFh+tnCntQ5bw1+
 pv5KbNkv9rckwfURtDGG7NA1
X-IPAS-Result: =?us-ascii?q?A0AEBADb0YlihwsR49RaHQEBAQEJARIBBQUBQIFPgiR+V?=
 =?us-ascii?q?S0EC0OETo5ogiUDaZYrh0wLAQMBDTINAQIEAQGCDoJqCgKFPwIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDgsJBQgKBw4QBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEECwsaAh8HAgJXBgEMCAEBg?=
 =?us-ascii?q?nkBgmIBAw0oC6t1gTGBAYIIAQEGhEofLCJSgVwJgRAsihkvhBsnEIFVRIE8g?=
 =?us-ascii?q?lMwPoEPgTwXBBiBRoNWgmWVcigEDwMcMjUSgSFxAQgGAwMHCgUyBgIMGBQEA?=
 =?us-ascii?q?hMSTQYdAhMFBwoGFg4UHBISGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDG?=
 =?us-ascii?q?AkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJL?=
 =?us-ascii?q?w0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcBx0DAwUmAwICGwcCA?=
 =?us-ascii?q?gMCBhcGAgIZWAooDQgECAQYBB4lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEF?=
 =?us-ascii?q?gICEggCCCcbBxYZHRkBBTYnBgsJIhYGCiILBgUGFgMkUScFCiEGIgEbApVRD?=
 =?us-ascii?q?IIBeicXAYEbgTOMe4hTqxg0B4ITgT2BQwyJTI1xhmwGEy2FRJEMDgaRdS2RD?=
 =?us-ascii?q?IUuII0MmgSBeIF+MxokgzcJRQECAQINAQICAwECAQIJAQECjh0ZHoNugQuDV?=
 =?us-ascii?q?oVMPzQCAQE3AgYBCgEBAwmFRwEBhVAtgTteAQE?=
IronPort-PHdr: A9a23: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
 vbTohRza6Ih+WW0i2o=
IronPort-Data: A9a23:CzWWr65RelGr5S+VcThJ4AxRtB7BchMFZxGqfqrLsTDasY5as4F+v
 mYcWmqCbvvYNjfzL9xzPYyy9BsOupTQn9FqQVc6+XphZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2+aEvfDjW1nX4
 Y6o+pWEULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 Pl/ibP3QiluBPLrk+1GfkFBM35QM5QTrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW9LN0nra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6DivIMHgWtr3Zkm8fD2a
 ukQRSU3NA36SQRNI1MINqoSnP2SiSyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjajkePcOWzT6t4HOpjPXG2yL9QoMbUrOinsOGm3WWwXEPTgIbXx23rJFVl3JSRfpzG
 XA7vSEA6pJt00eiFfSlRj3njnC960t0t8VrL8U27wSEy6zx6gmfB3QZQjMpVOHKpPPaVhR2h
 wfRxIiB6ShH4OHPFi71GqK88GvqURX5O1PucgcoYGPpCfHAqZs3lQjSTtsL/EWd0YOsQm6YL
 9yihiEyirNWsmXfzbmn8FXNjiijzqUloyYw4RjLGH2o5EV1aeZJhrBEC3CLsp6sz67AEDFtW
 UTofeDAtYji6rnTzkSwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbJtfIGK2M
 BSI4lIBjHO2AJdMRfAnC25WI5t7pZUM6fy5Cpg4k/ITPskvL1XvEN9GPxLIgzmFfLcQfVEXY
 MrHL5/1Ux72+Iw+gmP+RuEB3KUtyzx2zGy7eHwI50TP7FZqX1bMEe1tGALWMIgRtfrYyC2Ir
 Yo3H5bUmn13Db2vCgGKoNV7BQ1bfRATW8irw+QJLLLrClQ9QgkJVaSOqY7NjqQ+wsy5YM+Tp
 CDlMqKZoXKj7UD6xfKiMyg7OeywBMsg9RrW/0UEZD6V5pTqWq73hI93Snf9VeBPGDVLwaEmQ
 v8bVd+HB/gTGD3L9y5DP4bwpspueU3z1w6JOiOkZhk5foJhHlCYpIW7I1G3rCReXDCqscYeo
 qG70l2JS5Q0RzNkUJTcZsWpwg7jpnMagu9zAxDFL4ALKkXh+YRnMQLrifozL51eIBnP3GXIy
 AucRxsV/LGfr4gw+djPpKaFs4bwT7ogRBUHRTGD4O/vZyfA/2elzYtRa8qyfGjQBDHu5aGvR
 eRJ1PWiYvcJq1Z9tdYuGbhcy69jtcDkoKVXz1g/EXjGMwarB7dnLiXU1MVDrPQUlLpepBfwR
 U+FvNVXYO3bNMTgGV8XBQwkcuXaiaBKwGaPt6xtLRWo/jJz8ZqGTV5WYUuGhhtdG70pYokr9
 uEs5ZwN4Aulhxt2aduL0nJO+2KXIiBSWqkrrMhDUorslxZt1VxIJ5DRU3ek7JaKYtRKE08rP
 j7N2Puc3esBnBKafiphD2XJ0MpcmY8K5kJAwmgCEFLVyNDLsfk6gU9K+jMtQwUJlRhK3oqf4
 ISw25GZ+ElPw9tpuCSHd2WrBh0HGxCTvED8o7fMeKs1UGHwPlEh7kVkUQpOwKzd231RdH5X8
 dl0DU77BC3ycpiZMjQaACZYRj+KcTC13hLPkoarEqxp2nX8jSXN2seTWIbDl/cr7Q7dSqEKS
 SmGMducsZHGCBM=
IronPort-HdrOrdr: A9a23:GncF0K4yQbd/fOK9JwPXwOzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,243,1647298800"; 
   d="scan'208";a="14754331"
X-MGA-submission: =?us-ascii?q?MDHMi3b03hc2Pi4ncz3pduW1WIWhA2+0CNm8t2?=
 =?us-ascii?q?VExD2UrECrQ4xfqDMIH2HfgjxFS2/HJiI8K2fNaB2hzPRLZ6F1VY7i45?=
 =?us-ascii?q?Si/0vAaju74iOZsaBf8oqpenRdaVab1Wh25DxWEfLGD92Kk1zhHA/yvL?=
 =?us-ascii?q?RiFXr4KY3BBVki749zqtGGow=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 08:05:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1653199521;
	bh=SCI7VHGC/XuJEBdNh7i2jObQQ6/A014GUiDze04RAKQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=AAztZO1YSXLt8OayOOSXAPkg7w73e1v1rlCaV0SBlQUJ/sRGbmfbDP/imI0jVCmZj
	 j42SHSg28DnA6iuRpGO1wghJfPnVYmqwhfghYMskeUTYPNNMomy0nMFPVpQ6Ur1NkX
	 GA7XttjJSDm9t9U1zVMiVJwnOnsqf3W8F2wKCXg8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.139.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YJ1-1nuZb611TN-006hkF; Sun, 22
 May 2022 08:05:21 +0200
Message-ID: <67071e4b-d9a6-4fb4-62fe-280170af791b@web.de>
Date: Sun, 22 May 2022 08:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
To: Phil Edworthy <phil.edworthy@renesas.com>, linux-clk@vger.kernel.org,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220517133556.6934-1-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1O1Rnwa/6emRv3ujff+pdYMjErsEVPN9xV68c+Ns1wk/gym9F2i
 hlm6XvDxsoHXIAZhFhk2gCNJ19GfP1IYnKerU3Jn9CyDUMFKXViiKEtWKwTKJ/dQGJXfHgw
 tXH2jFwXU9050il4bTwF+9hLC75fIDvJaoJKJqaaVnCJtlKNJu0UIB3INIUzfXRMtPfBJG5
 pXEHJJO6vQGPIZyc3T40w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oP/JmXpIw1c=:/eJ660LJTgAI/b7ZXUiOLC
 jtg329EWEHkmDACZ6JlE5WDfDjaqwmAKSZbGRtQqA5L38eVVDJk/Bg7PHT01eJF8p7gd2UMOV
 qThW1EIyyK4Ckw55e0C2+HkoTrnanTlOsxloo4sM6JB5sD8sQ0E/OPFX+EIOO/XlaLQSi1XMs
 FC6A1yd6Wb03NaIW3mI3VtraVz0dAtgXc85bhRUlMLYVbGeCiDUpacOTLt1BTuKKacvHLdFxo
 8/rKAw4vvvIyfk3AaDkhzrHRPYdMTL9GPiIg9le1XKJ0xzd96/WPX6PvweUPX+d3lGvFhZF5g
 HAbdwrbE4XRD4bH3D3shGmNcgJmTM6stq/GiqlnwFAMZ3FSm/fGgCfdgXQK2dJdd+r4DswmVW
 WQed118xXDlH50CKmz6So91fPITJVXvv8d50csjXqhgCi3snvFaUqED2f/SrShCAUVgdPenxf
 Mdw2O+l2PWjPavX3WIP6CTW6nhramwvmy+312hJwJl4csS7H2dvK86MRrXwNiVHW/eV8HW7GM
 TtNsRAaX30K4VZ5TtkWIMMMg1sDG1WcuS1BP3CHWyCyocb5t9IxE1jpduKQt61W2F2i1s3nGx
 ACjeuAjwhE+u+Ggq1cC4aNF773cNx5UKPlKwVzdqPN0RJBs1hTwrT1HP5ZzN8f+wvP4SFkDlR
 pGeAugYfeMD6pC//lYtcSblaVwWp+XKZp0PgRRrLz5uDJWEUZuXEAYN4TIptVfKDniAqgUzDg
 XCr7bz2Vr5w5Xt0JnVd/9FGwXLVbUwnt5ZTV+N9MxcDHSn3vCWRItqk0b05dmXWQQO+YnESxZ
 TIdBmeEGRDd+ge1zwxOX87o1iNfOfVeAV8GiGAzcLME2QP2fxZ85XYlP8fxD9tt+SXN4oVot8
 vF3iSvr89CQaHLOQQJKKR5NoeWcmFINnSfXrzE2ww8hrKbpeTrLXxExr+z+MfZ7uze/wSqvSl
 4rGnbyVzua+KZcfv9a905wLvSVyflZL9emrjOvRWRMRgGq9/hS5Sswmj1Pv9TctMgWsJ4nqz2
 eSxJX499dhTeTbCPysTyeUfFtHQiFUbejDOFicp7D37cpB/o70/wQKOyOQC3KcdrBuFxd9PJa
 SRmVAtbgU0a30yrvIw3tMVoBsRU1dDHqvIZ6HOO881+uZqLew0JX9dOCw==
Subject: Re: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 410
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/67071e4b-d9a6-4fb4-62fe-280170af791b%40web.de>


> The clk_disable_unprepare() function only calls clk_disable() and
> clk_unprepare(). Both of these functions already check the clk ptr
> passed in using the IS_ERR_OR_NULL macro.


How do you think about a wording variant for the commit description
like the following?

The pointer which is passed as the parameter =E2=80=9Cclk=E2=80=9D to thes=
e functions
is checked already by using the IS_ERR_OR_NULL macro.


>                                           Many drivers already omit
> any checks on the clk ptr, so it is safe to assume this is true for
> all call sites.


I suggest to adjust this information and conclusion.

Do you expect that all driver implementations can depend on such functions
which perform a well-known input parameter validation?


I propose to extend source code analyses and corresponding transformations
accordingly also by the means of the semantic patch language.

The mentioned macro detects null and error pointers.
This detection can obviously be split into two cases.

Various contributors showed special care for the handling of null pointers=
.

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/s=
cripts/coccinelle/free/ifnullfree.cocci?h=3Dv5.18-rc7

* https://build.opensuse.org/package/show/home:elfring:semantic_patching:D=
eletion_of_checks_before_specific_function_calls/Deletion_of_checks_before=
_specific_function_calls_in_Linux_source_files


Can the software development attention grow for error pointers in similar =
ways
(besides existing analysis approaches)?


=E2=80=A6
> +++ b/scripts/coccinelle/api/clk_disable_unprepare.cocci
=E2=80=A6
> +/// Unnecessary check for valid ptr before calling clk_disable_unprepar=
e


Point questionable checks out before calling clk_disable_unprepare().
Some pointer checks do not need to be repeated because called functions pe=
rform
input parameter validation before further data processing will happen.



> +// URL: http://coccinelle.lip6.fr/
> +// Comments:


Would you like to add anything for the attribute =E2=80=9CKeywords=E2=80=
=9D?

Regards,
Markus

