Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B881CE8E67
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vebzwISlthNkZNCrweDEHwx1T3ez1ATRthv5SzBIP1I=;
  b=W4WGgVIwqoHKhSW0zO6TL59e94IW95iiSRAdQ3b97dYV9a45dS9uGTgH
   eoWF1KZeDRPNgfM/ywud54vwLKKQOjfnAymYRe/r3zzhhtUoJsEG3yNLe
   MxSozCg+PELP+fm1yZ5DjNhcOwR5gZfwwli8Zs0iNE6u2HUdVapMxTRU9
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190537158"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 13:56:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D757E013D; Thu, 24 Oct 2024 13:56:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4895E0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 13:56:44 +0200 (CEST)
IronPort-SDR: 671a35fc_6wo24c4FlxxUK4aGfo0VGa7xVnZa5HhuhsWmGxJwSveULXQ
 mEhuflHvDlbCszEba0u0PFObZ89hck6jDfEIMdA==
X-IPAS-Result: =?us-ascii?q?A0E6CABQNRpn/xOg6VVaHgE8DAILFYFTgikbB3ZaESIHC?=
 =?us-ascii?q?EiEVoNPjh+eF4F+DwEDAQ01DwQBAQMBA4IMjRoCHwYBBDEIDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQKBCggLhTVGDYJbO4IWLA2BJxV2AiYCc?=
 =?us-ascii?q?wEBgn0BgmQDBK9ugTKBAYMcgWDZN4FmBoEaLoVqgmIBincQFQaCDYE8CwOCP?=
 =?us-ascii?q?QgBhX2DDoJpBJIFghCJWiWJL4JAhTOJXYFNHANZIQIRAVUTFwsJBYk1gyaCF?=
 =?us-ascii?q?IQRgUUBg1+BZwlhiU6BPoFZgzlKhS2BBoJNak43Ag0CN4IkgQCCT4ElBAWEX?=
 =?us-ascii?q?B1AAgELbT01CQsbQ6t0gVlHg3EsewpAL4EGpAahaYQkBYwRlS4GDwQvl0AUk?=
 =?us-ascii?q?niYd6kggWkBOoFZTTQEO4JnUgsOD44tFoNYyj1CNTsCBwsBAQMJjyGBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:dBDolq3rwOjlieJOQ/bD5eZwkn2cJEfYwER7XKvMYLTBsI5bpzIAz
 mJJUDjSO/vfM2r3et50YIm/9UxVsJDdzYAxSgQ+3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8glaYDkpOs/jf8Us14Kyo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWyf86uctNEYtAa4d6sZ4KDFq+
 cQhBglYO3hvh8ruqF66YvJpmtxlLM7wIJhZsXYm0DKx4fQOEc2FGf6Ro4YGhHFp16iiHt6GD
 yYdQTZidhnDSx5JPUwQBtQ1m6G1hRETdhUB+QrI/vVuvze7IApZ14nwPN/WSI2zBtxtnmeWg
 XDU+EvbO0RPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTuvylkgi+XMlDM
 Aof/WwzrsDe6XCWczU0ZDXgyFbsg/LWc4M4/0ASsWlhFoK8D8el6mk4ovppc9k6rIk2Qic2z
 RmCmJX0BlSDdZWLHGmF+O78QSyaYEAowa0qPEfojjfpJ/HgpoYoiRyJRdElDa3dYhjdB2Tr2
 z7TxMQhr+x7sCPIvplXOXjEhTW3oZaPRQlz+wa/sqdJKO9mTNbNWrFEImQ3IRqNwEh1g7VBU
 LU5dxCi0d0z
IronPort-HdrOrdr: A9a23:QFKc2aMkr2Vpu8BcTtajsMiBIKoaSvp037BZ7S5MoHtuA6ilfq
 GV7ZEmPHDP5Qr5NEtApTniAsW9qBHnn6KdMbNwAV7KZmCP01dAR7sSj7cKrQeQeBEWutQz6Z
 td
X-Talos-CUID: =?us-ascii?q?9a23=3AN4LTh2gJ+ctGFwzHffAHBAuJDjJuLm303jToJFS?=
 =?us-ascii?q?EKmN5aLK8GXucwJpKqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AD5LG9A2VaTdOlh+3O20mwGcspzUj5JWzBEUOo8Q?=
 =?us-ascii?q?/+NC8NQ1+HCWPixuVe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190537147"
X-MGA-submission: =?us-ascii?q?MDEMztAcPnWNZlWGD/W8whKf0GSynBxhjAmVWM?=
 =?us-ascii?q?ADIiF3kKZHTRdIh8FvPmwvay84X+1PEVhW6IREVsHaWkQBBMebW0IUrX?=
 =?us-ascii?q?3SvLyigzCHz9CtEDXCdeNwfzqhRBX4WILKgKrW5WDexCaMZipuzyhWAa?=
 =?us-ascii?q?ReI7bXcblijl9x4hRS0vP4Cg=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 13:56:42 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t3wS9-000000003mL-7Xe9
	for cocci@inria.fr;
	Thu, 24 Oct 2024 12:56:33 +0100
Message-ID: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
Date: Thu, 24 Oct 2024 12:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
To: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1918
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/11e0e0d6-a20f-4740-adb0-2f72b79df5e8%40knosof.co.uk>

All,

I'm interested in finding the start/end line of
functions, and the pattern below does this.
However, return statements cause multiple matches to
occur.  For instance, in the following code the python
in the cocci script below is called twice.
This is not a problem because I can filter on the
highest line number.

The real problem is the performance hit.  Matching
a function containing lots of returns takes forever (there
are lots of these in the Linux kernel).  I am regularly
seeing timeouts after 600 seconds (the specified timeout).

Is here a way of improving performance, given that I am
not interested in the returns?

void f2(int a)
{
a++;
if (g)
    {
    a++;
    return;
    }
}


@ func_def
@
identifier f;
parameter list parms;
position p_1, p_2;
@@
f(parms)
{@p_1
...
}@p_2
@

script:python @ func << func_def.f;
                 parm_n << func_def.parms;
                 loc_1 << func_def.p_1;
                 loc_2 << func_def.p_2;
               @@

import sys
def printf(format, *args):
     sys.stdout.write(format % args)

printf("%s,func", loc_1[0].file)
printf(",%s", func)
printf(",\"%s\"", parm_n)
printf(",%s,%s", loc_1[0].line, loc_1[0].column)
printf(",%s,%s\n", loc_2[0].line, loc_2[0].column)


int g;

void f1(int a)
{
a++;
}


void f2(int a)
{
a++;
if (g)
    {
    a++;
    return;
    }
}

tfunc.c,func,f1,int a,5,0,7,0
tfunc.c,func,f2,int a,11,0,17,3
tfunc.c,func,f2,int a,11,0,18,0

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

