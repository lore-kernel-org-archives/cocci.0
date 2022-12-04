Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7D5C352A1
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 02:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=VA8cDbnBrHHBlJv+1vy4qYpqEb/R+6+3GI39E9YZpDI=;
  b=BnrrVuAEFGCcq/doSOKcF4pb5BK2oDsBArnYQna2nQingLgXjLOshNaX
   rCY6QreOGawgBJN3plqIU9iHcCAdu5OnDuPfhcUkWixIQ7+oFcGcT9kfZ
   qG2U+Rg3JHCnIhG/kIzgj+n2ZB7AS2qAZLRyxd6ANZWpZcadfUwBZ2J4w
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.96,216,1665439200"; 
   d="scan'208";a="81558058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 03:04:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00299E0269; Sun,  4 Dec 2022 03:04:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C1DDE013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 03:04:37 +0100 (CET)
IronPort-SDR: 638c0034_4B+HbRXaXZ92XFdGQymoXE7SmPSKYGgIxH8nVWQpJkDuqPD
 7dEvMyOdxZGB6kgnH+Kr4BfPR4mHsaq6GoXT2zQ==
X-IPAS-Result: =?us-ascii?q?A0E9AwC7/otjmBOg6VVaHQEBPAEFBQECAQkBFYFRgUMCZ?=
 =?us-ascii?q?oEFVi4HCEWET4NPrQMPAQMBDRQCAQIODg8EAQEEA4ILiAQCHgYBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBAQEBAQEVCRkFDhAFI?=
 =?us-ascii?q?oVoDYI1IoIELA1SgSEVdgImAmwIAQGCegGDIgMErwSBMoEBgxaBXJplgWEGg?=
 =?us-ascii?q?RQqAgEBkS0QFgaCDYE8D4hDgwqCZwSWd2IlBA4DGSsdQAIBC20KQzUJE0wQG?=
 =?us-ascii?q?xwbB4EMKigVAwQEAwIGEwMiAg0oMRQEKRMNKydvCQIDImYDAwQoLAMJQAcmJ?=
 =?us-ascii?q?DwHVjcFAwIPIDgGAwkDAiJUcwIuERUFAwsVJQgFSQQIOQUGUxICChEDEg8sR?=
 =?us-ascii?q?Q5IPjkWBidyDg4TA12BaQSCLl2YVIIhgTmBRaNioBqDcwWLTJR0Bg8ELpZwF?=
 =?us-ascii?q?JIWlz+iEYVpgXkjgVxNNASDIk8DGQ+OLA0Jg1CKXkE0OwIHCwEBAwmKHwEB?=
IronPort-PHdr: A9a23:N2oDUxwAouaq6FnXCzKgwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hGZvKwm0AWBHd2Cra4e16yO6+GocFdDyKjCmUhKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizexf7N/I
 A+roQnMucUbjpVuIbs1xhfVv3dEYetbyX1nKF6Jgxrw+sK894N//ipNvP4s68FPXaLmcqoiU
 LdWFi4mM2c75M3qsRnMUw6C7WYCX2sVjxRFHRHL4An1UZntvCT6sPF92DSBMs3tUb80QzWi4
 Lx1RxLulSwKKiQ28GDTisx3kaJbvBesrAFxzoLIfI2YMud1c6XAdt0YWGVBRN5cWS9PDIyzY
 YQBEeoPPeFFoYbhqFUDtge+CAu2Ce/z1jNFiH370Ksn2OohCwHG2wkgEsoAvnvKttX6KqQSW
 v2ywqLVyTvDaPVW1inm6IPVdR0uvO+DXahufsrS0kQvFAXFjlKLqYziMTOZzPgCs2+B4+p9V
 uKikmgqoBx+rTaz3MkjkJXJhp4LxVDe8yV02II4KNO5RUJnfdOpHpVeuj+VOYdoXM4vR2Fmt
 Sg1xLAbtpC2fjYHxpQ5yxPQd/GJc4iG7BL9WOuNLjl1h25odbK5ih2v/0agzej8WdO10FZMt
 idFidnMuWoV1xPN88SHTfV98l691jaIyg/c9PtILlwzlareLZMq370+loILvEnAHiL6glv6g
 aGYe0k+5+Sl6vjrbq/7qpKYL4N4lwHzPro0lsGxA+k0KAsDUmmB9eiiybHu+1DyTq9Qgf0si
 KbZtYjXJcQFqa69BA9Yyp0j6xOjDze+ytgYnX4HLElZeBKclYTmJ1bOLOrlDfe8m1iskTFry
 O7aPrD5AZjALmLPnKnvcLtz8UJQ1Qs+wcxF655JDrwNOPfzVVXwtNzcAB85KQu0w+P/Bdpgy
 IweQ3yAAqyCPaPRt1+I4fkvI+6CZIMPpDn9LOIp5+PtjXMhn18SZrGm3YELZ3CgAvRmP0KZb
 GLxjtsZC2cFohI+TPD2iF2FSTNce3GyUL4g6TE6E4+mFofCRoW1gLObxiu7H5tWZnpHCl+WC
 3voeZ+ECL8wb3eZJcRqkxQFU6KgQskvz0KArgj/npZqNOfXsghQl5Xl2cM9s+Hejxwx3T9yC
 N+a3SeGSCdpnTVbFHcNwKljrBklmR+42q9ijqkAfTQyz/ZAUwNhcIXZ0/Q/ENfqHATIYtaOT
 l+iBNSgGzA4CNwrkJcVe0goPdKkg1jY2jayRacPnumHCYY58Yrf2X/qIMg7wHGAyapyx0I+T
 J53PHa9zrV66xCVAofIl0uDkKP/eakG0S3l92GE1m2A+kpfFhNzAu3eRX5KXkLNtpzi41/aC
 b+jDbNyKgxa1cuLMbdHcPXyiEleAvfkI8jFJWm23XqzbfqR7pWLaoeiO2AU3SGGTVMBjxhW5
 nGecw43GiampWvaSj1oD1PmJU32o6F4rzugQ0k4whvvDQUp3qep+hMTmf2XSu8ClrMCtiA7r
 jxoHVG7l9vIAtuErgBlce1Se9Q4qFtA0GvYsUR6MPnCZ+hui0QTcCx0uUT10BsxAYIGjMtr5
 HImwQxuKL6JhUtbfmDQ1pTxN7vLb2jqqUDyLfSNgReHjo7Qo/ZcjZZw40/utwyoCEc4pnBu0
 t0OlmCZ+o2PFw0KF5T4Tkcw8RF+4bDceCg0oY3OhhgOeeG5tCHP39UxCa4r0BGlKp1TPbmJF
 yfxFcoBAMboI+tshlvjPXdmdKhCsbU5Oc+rba7M1KOxMeVInzShlmNJpot6lF+PvXk0WqvD2
 JALxOud1w2MWmLnjVuvhcvwnJhNeTAYGmfXJTHMPIdKfeUyeI8KDTzrOMir3pBlgIarXXdE9
 VmlDldA2cmzeBPUYUavlQFX0E0WpzSgl07ah3R4niskrYKc2ivVxOqkfx1BJ20DSGR5jFjqK
 JS5lJhKAQ7yNFNvzUX9ox+rj6FA7LxyNWzSXVtFc02UZyl5X628u6DDK89D5ZU0sDlGBeG1Y
 FSUULn48FMR1yLuGXcbxShuJ2zs4M6i2UUk0CTEfSUWzjKRY8x7yBbB6caJQPdQ2mFDXyxkk
 XzMAUD6OdC1/NKSnpOFs+akVmvnWIcAFEujhY6Gqia/4nVnRBOlmPXm0NHqCwU5+Sz90MJtW
 2PDq1DhYcO4ssbyefIiZURuCFLmvoB2F5tzkaMzgpYL3nZcjZLT4HlNwi/jdN5c36z5dn8EQ
 zUGlsXU7AbS00pmNnuVxoj9Wyb4oIMpd5ygb2gRwC5489FSBfLe8ulfhSUs6AnwvUfLbPN6h
 DtY1fY+9CtQnbQSoAR0q0fVSrEKQRsIYGq2zE/Oto7m6v0QPjnncKDshhoj24r6V/fb81gaA
 DGjJ98jBXMit5Qidg2KiiCurNmjIoS1D5pbtwXIwU2Z1a4FdNRozKVM3W09ZCr8pSF3m7N91
 0c1m8jk5M7bey1o7PD0ERlNfiv8Y8dZkt30pZ5Xhd3en4WmH5E6Xy4OQIOtVvWwVjQbqfXgM
 Q+KVjw6sHaSX7TFT0eT70JvrnSHFJ7OVTnfPH4C0dBrXwWQPmREhRwMGjU9hYIiUAutgtHiO
 Et0/TEe4FfkpwAEmr8ubUKkFD6B/EHxO389U/39ZFJO4xtH5lvJPMDW9e91EyxCv9WgoAGLN
 m2HdlFIAGUOCQSPA1HuOKXr5MGVo7XeXLHlaaKQOfPX+L87Nb/A35+k34p48izZM8yOOiInF
 Pgnwg9YWmg/Hc3FmjIJQihRliTXbsfdqg3vn08/5s257vnvXxrioIWVDL4He9li4R21qaSFM
 PWXimByLnBF1dlfoB2AgKhax1MUhyx0InO1Fq8csCfWUK/KsrRSEwZdayRoKNAO5KV6wwoHa
 qu5wpvlk7V/iPAyEVJMU1fsz9qoacI9KGa4LFrbBUyPOefONXjRzsrwe6/5VaxIgbAeqUiro
 TjCWRyGXHzLh3zzWhuoK+0JkCyLIEkUptSmahg0QWGrWtviblfT2DBfjjsx2ro6wHjNc3MfY
 2EUm6JltbiM9WVYhe5jACpK6Tx4Lrvd8858x+reLY0Rv71gBWJplLACiEk=
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:HHT/uK4t8hcEkMI9uQPXwN/XdLJyesId70hD6qkDc3Jom6uj5q
 STdZUgpHrJYVkqNU3I9erhBEDiex/hHPxOi7X57Y3SPzUO0VHAROpfBODZsl/d8kPFl9K1mZ
 0OT5RD
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,216,1665439200"; 
   d="scan'208";a="41646283"
X-MGA-submission: =?us-ascii?q?MDGF9UydYT7PQ2S7m6ozyjGWU0dtifece5F/kY?=
 =?us-ascii?q?s4DHvQLEIiGsA7BEnKgkO5Vgj4Hbv8m7b6t3s0l7zjHZ9qiboGw/ynmK?=
 =?us-ascii?q?ymgieT49iRvFS/ccGHDdRa0/4Ge//EGX1ZEgCeR10SjmPnTEMuslAijA?=
 =?us-ascii?q?X4sKxZCI9jV+xRcdr8fJx6gA=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 03:04:35 +0100
Received: from [152.37.86.21] (helo=[192.168.1.100])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1p1eMs-000A9J-7l
	for cocci@inria.fr;
	Sun, 04 Dec 2022 02:04:34 +0000
Message-ID: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
Date: Sun, 4 Dec 2022 02:04:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: cocci@inria.fr
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Searching for ++ of volatile variables
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 759
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/a9cad00c-ede3-338d-da7d-801dab7d51c2%40knosof.co.uk>

All,

I want to find volatile variables that are
the operands of ++, --, or the lhs of an
assignment operator.

The script below works for declarations
within functions, but it would be more flexible
if I could check whether the declaration of V_1
was volatile qualified.

I' having the usual problem that occurs when using Coccinelle
after a long time away, I cannot find the example
I need (assuming that it's possible to access the
type information in the Python script, or some other
way).

Actually the line
V_1 b E_1;@p_1
does not match anything.  Is this because the assignment
operators are not considered to be binary operators (they
are)?

@ volatile_op @
expression E_1;
identifier V_1;
position p_1;
binary operator b = {+=,-=,&=};
@@
volatile int V_1;
...

(
V_1 b E_1;@p_1
|
V_1 |=  E_1;@p_1
)

@
script:python @ expr_1 << volatile_op.V_1;
                 loc_1 << volatile_op.p_1;
               @@
print("--- volatile op")
print loc_1[0].line, " ", loc_1[0].column, " ", expr_1


Some C source to test the script

volatile int vi;
int i;

void f(volatile int p)
{
volatile int vl;

vl += i+0x88;
vl -= i+0x88;
vl &= i+0x88;
vl |= i+0x88;

p++;

vl++;

i++;
vi++;

}


-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
