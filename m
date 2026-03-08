Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101FBEA8546
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=7XPqXAkMZUA/FZtH475v6U5LN2gddd365age488PX0Y=;
  b=ASKP4LKjgntuu5uohg5YHGp2J+XvglK8NB38+2c26PqsNlmoccX7M7Af
   kmn3ePsm/fISfFiXlFArR4CM6ZbMn13t9Vh3X8/1FMQdUjr7IyrS1tRHP
   2wHCHUjm6lQuhpdn9kNnnD0vW85xV7sHMEktn0RRZgIbG/pCxMk76loUy
   s=;
X-CSE-ConnectionGUID: cRmH5oDXTHaCDKRXw/kt9w==
X-CSE-MsgGUID: OhcV5PYHRYWs2Mlm6/V+Rg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266761934"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 22:40:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 486C18167B; Sun,  8 Mar 2026 22:40:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 364DC81236
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 22:40:22 +0100 (CET)
X-CSE-ConnectionGUID: tKYcl3L6QquOMVfQan0C2g==
X-CSE-MsgGUID: nAgvw5COREWQpw1uVNG+TA==
IronPort-SDR: 69adecc6_DnLjc/4uWj6wC/WJZIsid+SUb+MrwdFjUW5yiyQMRZL+ww1
 JLl/ZkgRJpKq//x9FWvddJsw6meWQaRl+Swraxg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FXCQBS661pgw82ttVaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VKBVgJngWU0BwhJhFiIe403m14PAQMBDRQTJwECBAEBAwSFAI0kIAYBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBOQcOO4ZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAR0CLD9JDwEFCAEBODQCJgJzAQGCfoIjAk8Hr?=
 =?us-ascii?q?AKBMoEBggwBAQaCadlBgWcJFYEKLAIBAYVtgmUBhg+FIYFJRIE8C4gOOIMOg?=
 =?us-ascii?q?mmCJoEOgX+RLIFKHANZLAFVExcLBwWBZgOBBm4yHYEjPhczWBsHBYU/D4lkb?=
 =?us-ascii?q?oETgwQCAQttPTcJCxsEPY5yPoMvE4FHgVySdLIFgT6EJoFkDJ9tBg8EL6prm?=
 =?us-ascii?q?QajaYVYgX8jLoEuTSODN08DGQ+OOoNnySdGMjwCBwEKAQEDCYVEAQ8BAYxIg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23:uI4wGxJ8mvn5tf/xItmcuC5sWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEubM11BSTAtuBu7ptsKn/jePJYSQ4+5GPsXQPItRndiQuroE7uTJlK+O+TXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL19I
 RmssQndqsYajZVgJ6sw1BfEoWZDdvhLy29vOV+ckBHw69uq8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQwSX6HQTS2kbjBVGDRXd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54
 Kh1ThLjlToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+d4c6jAf90VWHBBU95SWSJPDYyzY
 ZUBAeocM+lEoIfwvEcOoBikCAWwGO/j1D1Fi3nr1qM6yeQhFgTG0RQ9Ed0UtXTfscv7NacdU
 eC00qbI1yjIYvRN2Tjn7YjIbhAgof6NXb1ua8rc0kwvGBnEjlWUrozpJS+a1uMIs2WC6edrS
 O2ghXI9pQ5rvjiv2tkjipPPho8Nzl3I6yt3zYUoKdGkRkB2Zd+pHZhfuSybK4d7QsEvTmFot
 is7xbMLtpC2cSgUxJknxxDTdfyKf5aG7BzjSuqfLzF1j29mdrKnnxu+71Wsx+PmWsWp01tGs
 DBJn9nDu3wXyhDe6s6KQeZn8Ei7wzaAzQXT5/lEIU8qkarbLIYswrsqmZoStUTDGTX6l1nxj
 K+Tbkkk++6o5Pr7Yrj+uJOQKoF5hhvjPqkthMCzG+Q1PwcUU2SG+emwzLjj8lf4QLVOgP02i
 K7ZsJXCKMQAvKG5BhNV04Ys6xa+ETimys8VnXwdI1JEfBKHiJLlNE3JIPD9Ffu/mUijkC93x
 /DaOb3sGonCLn/fn7j9fLZw8FVcyQo2zdBH/Z1YELABIPTpWk/wrtPUFBE5Mxasz+bhE9pyz
 pkeVn6XAq+FLKPStkeF6v83L+mDeoAVvzXzJeI96vDukXE1gUUdcre33ZUUcn61BvFmI16WY
 Xb1jdoNC2IKsRA/TOzuj12OSyJcZ3G3X64k+z47C4OmDYLbS461j7KO0jm1EIFKa25AElyDD
 HLoeJ+eW/gQcC+cOtZvnCQLW7S5UI8hzR+uuRfgxbd7M+Ta5zUUtYn71Nh7/+LTlQ899ThzD
 8mFyW+AU3x6kH5bDwMxiat4qkd84laFy6lxxfJCRvJJ4PYcaQ4/faLNwO13EZimQQvEYsaGS
 Vu8atCvADU2CNk2xoldMA5GB9y+g0WbjGKRCLgPmunTbHRV2qfV3nyrYt14126Dzq4qyV8vX
 spIM2SiwK957QnaQYDTwA2Cj6j/U6Ma0WbW8Xubi3KUtRRDWQtsQKrEUGo3Y0LXqdO/7UTHH
 Pe1EbpyCgJa0oaZL7dSLNjgjFFIXvDmbc/XZn6glGa9Hz6Nz7KIa8zhfGBOlD7FBh08mhsIt
 W2DKRB4BiqlpDfGCydyEFv0f0722ex3qXe8CEQzymlmdmVH0Ly4sl4QjP2YEbYI264c/T0mo
 HNyFUq82NTfD5yBoRBgdeNSe4F15lAPzm/fuwFnW/7oZ6l/ml4TdRh2tELyxl12DItHi80js
 HItykJ7N6uZ1FpLcz7Q04r3P/XbLWz7/RbnbKCzuBmWy9+T5rYA6fkig1DqvQWuUEEl9jQv0
 tVY1Wed+oSfFBAbAtr6Vkc68QQ/pqmPOHBmodqEjzsxbe/t72ynuZphHuYuxxe+cs0KNaqFE
 FW3CMgGH420L+dsnVG1bxUCNeQU9aguPsrgeeHVvczjdOtmgj+iinxKpY5n1UfZvTF1T/LZ0
 JcI2dmd1wqDUHH3i1Lr4aWV0chUICofGGay032uH4dUerx9fIsRIWKnIsmwgN55gtS+E24d/
 1mlCVQc3cavchfHdF3x0zpb0kEPqGCmky+1p9BtuwkgtbHXnCnHwuC4MQECJnYOXm5py1HlP
 YmzidkeGkmudQkg0hW/tw72wK1SpaI3KGe2Iw8AZCHzM3BtU6aqnr+LYspIrpgvtG1bXf+9b
 laTVrPm60FDiGW6TzEYmWx9Lmzis46xhxFgjWOBMHt/yRiRMdp9wxvS/p2URPJc2CYHWDgtj
 DDWAlamONz6td6QlprFrqW/Tzf7D8YVKHmxi97c8nLmtggISVWlkvu+m8PqC10/2C7/jZxxU
 DnQ6Qz7ac/t3ri7NuRueg9pAkX94ox0ANIb8MN4iZcO1HwdnpjQ82AAlDK5KtxexbPxbXcXb
 TsCwtrSpgPi3QcwSxDBj5K8TXibzsZ7MpOha2YKyy084tpiDa6V6LsClixw6Andz0qZcb12m
 TETzuEr4XgRjrQSuQYj+S6aB6gbAUhSOSG/3wTN9d21q79bIXq+abXlnlQrhsivVfvRx2MUE
 Ga8YJopGjV8q9lyIE6ZmmOm8ZnqIZHRdY5B7ETP1U6Q1a4IdNRp0aBV4EgvcWPl4S9/krV91
 Ew0m8zn+tHWcSI3rOqvCxpcfFUZfusr8yr2xeZbl8eShcW0G4l5Xy8MV93uRO6pFzQbsbLmM
 RyPGXsysCXTFb3aFA6ZoEBoyhCHW4isLG2SLWIFwM9KQRCcIEsZiwcRFDk3hZ82EAm2ydepK
 h4ioGlBvBil9l0Vl6phLFHnX33apRu0ZztRKtDXNxdQ4gxYpg/UPcGY8uNvDnRY85mm/0SGL
 m2WYRgNDHlcABXfQQmzZP/zuZ+Zrrv9ZKL2NfbFbLSQpPYLUv6JwcjqyY5653OWMc7JOHB+D
 vo9004FXHZjGs2flS9cLk5f3y/LccOfow+xvyNtqcXquu/iXR7+6oqCEZNXONRr/Fa9hqLJZ
 IvyzG5pbC1V0J8B3yqC0L8EwFsbkD1jbRGoGLUEsmjGS6eayco1R1YLLih0MsVP9ac12AJAb
 NXaht3C3bl9lvcpCl1BWA+pioSzaMcNOW34KELfCRPBKuGdPTOSiZKSA+v0WfhKge5TrRH1p
 TuLDxqpIGGYjzewHxG3bbMW1XrdZUwE/tzhNE4qUzeGLpquawXnYoUu1ntvkedy2y6MbD9Gd
 mIsO1VEqrnahcu3qvB2GmhGqHFiKLvd8854x+zRK5IR9/BsB3Yt/wq/yHEzyr9SqipDQa4t8
 BY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:k2wDWK6yR1fMqVCM0APXwM7XdLJyesId70hD6qkDc3xom6uj5q
 eTdZUgpHvJYVMqM03I9uruBEDtewK/yXcX2+cs1NWZMDUO0VHAROtfBODZsljd8kPFh41gPO
 tbEpRWOZndJRxTkdv6iTPUL+od
X-Talos-CUID: 9a23:7ua1qGFr6rTjA18yqmJ7138fHpsBLETE0VD1HUGBAGAxY+eaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AHgOqOQznALPDxhjN+yO9myAnOn6aqKKHB14SzL4?=
 =?us-ascii?q?hgeS7DDRvYiqjqhv0fqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266761924"
X-MGA-submission: =?us-ascii?q?MDEqFhwsZ5Hcdt6C0g1C1CPV39qzv8fF+6dUKl?=
 =?us-ascii?q?rxyQeCpitYyTxzuENq3g2giURhdNoQ+zvINPOcK0yMDOj6OMaTIYGl3a?=
 =?us-ascii?q?ucpBAtvaEA5I76wYDfAgxS2Y0ZHzPOG5wwAtIlJNo/RfyBd8QaXRgOgL?=
 =?us-ascii?q?A84xr60uPEeh3lMBzMdohawQ=3D=3D?=
Received: from msg-4.mailo.com (HELO mailo.com) ([213.182.54.15])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 22:40:21 +0100
Received: by b221-7.in.mailobj.net [192.168.90.27] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Sun,  8 Mar 2026 22:40:21 +0100 (CET)
X-EA-Auth: 4ac5wEiVRG2fMtAoeb+pd4vaXwrJBvDW595fFNfICPvEsdrDCWMFRtsYO2+40c8ym50lR7NOX/tdUgC/9S2ykByyn8k3Gk4bKZVAXAQMMBs=
Message-ID: <fc5aa4f0-0134-475a-9220-dedc71955fe7@mailo.com>
Date: Sun, 8 Mar 2026 21:40:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr
From: Sam Tygier <samtygier@mailo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [cocci] c++ scope resolution operator
Reply-To: Sam Tygier <samtygier@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 3343
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/zuiUbG0HTna9_u5hSmHOHw>

Hi,

I am having trouble using Coccinelle with C++ around scope operators, 
e.g. std::cout.

For example this works as expected (replaces the string):

hello.cpp:

#include <iostream>
using namespace std;
int main(){
     cout << "hello";
     return 0;
}

hello.cocci:

@@
@@
- cout << "hello";
+ cout << "hello sam";

But the actual I want to work on uses explicit namespace scopes

hello.cpp

#include <iostream>
int main(){
     std::cout << "hello";
     return 1;
}

hello.cocci

@@
@@
- std::cout << "hello";
+ std::cout << "hello sam";

gives an error:

$ spatch --sp-file hello.cocci hello.cpp --c++=17 --debug
init_defs_builtins: /usr/lib64/coccinelle/standard.h
-----------------------------------------------------------------------
processing semantic patch file: hello3.cocci
with isos from: /usr/lib64/coccinelle/standard.iso
-----------------------------------------------------------------------
@@
@@
- std::cout << "hello";
+ std::cout << "hello sam";

minus: parse error:
   File "hello.cocci", line 3, column 6, charpos = 12
   around = ':',
   whole content = - std::cout << "hello";

I am using coccinelle from the Fedora package 1.3-3.fc42

$ spatch --version
spatch version 1.3 compiled with OCaml version 5.3.0


Thanks,
Sam



