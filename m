Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F2FD68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=61FzWbZx8SVE6r33ggD3SgPEq3e2wgbU4/WDXmU67Oo=;
  b=LMq/ZPM0/y3swgdm5CsOSp/b1xI8U5Wgb/MuBIp9VTBL2rPShFvFUK8I
   jCgZgg66WXve6oynHxcITpTefWLvQAnGlR0XAVYiVAlkysVVZxK6TtYxf
   d8/wb8O4NOBUGWFGLHT8do829oLa/lQ/QcTHfk+7zQ60DDy1YyQ+GXrIz
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169352"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6818E0DA0; Fri, 15 Nov 2024 23:35:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7EA3BE0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:50 +0100 (CET)
IronPort-SDR: 6737bbaa_VkFD5JuL8mIJifXvnfBjYIMpL6c4A51MOfSDaYuXgAa7Qk6
 Q8c7jtRpeRBls6kD3frbfy6ajKh3c6JBzdoELdA==
X-IPAS-Result: =?us-ascii?q?A0EgAAC+ujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHYlRi3aQTYFWgUA+DwEDAU4BAgQBAQMEgUyDN?=
 =?us-ascii?q?AKKSwIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABg?=
 =?us-ascii?q?QyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4CA?=
 =?us-ascii?q?QMREgQZAQE3AQ8lAiYCAkYQBgESgwGCZQYCn04Bh2ABAQKLI38zgQGCDAEBB?=
 =?us-ascii?q?oJn2TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIFKgQaCLYRYBINCgmmCRWhNg?=
 =?us-ascii?q?mh2JYUGg3mZeAk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7g?=
 =?us-ascii?q?RMvGyELXIEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA?=
 =?us-ascii?q?4M8gk5kLh1AAwsYDUgRLDUGDhtDAW4HnwJGgzRZKA5LMASBK5Neg3KNQqFrh?=
 =?us-ascii?q?CShXQEyqk4uh2SQZSKoVIIYOoFcRgcjFYMiTwMZD44hDBaDWI8+AbYZQzU7A?=
 =?us-ascii?q?gcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23:hNiktBHJZrTmycVFms6Yr51Gf+9bhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21RmTAc6Ct6kMy7KP9fy7ASpYudfJmUtBWaIPfidGs/lepxYnDs+BBB+zB9/RRAt+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuNQajZF8Jqs+xRfFv3RFdupLzm9sOV6fggzw68i+8ZJ/6Shcp+4t+8tdWqjmYqo0S
 qBVAzshP20p/sPnsgXNQxWS7XUGSGUWlRRIAwnB7B7kW5r6rzX3uOlg1iSEJMP6Vb87Vyis4
 KdtUx/olTwINyUl/2HNi8x/l7xUrRS8rBFi2YHUYYWVNP1jfqPBeN4RWGRMUtpNWyFHH4ixd
 JUEAfYfMulEron9v1oOogW4BQmwH+Pk1ztEimbr0aEmz+gtFAfL1xEiEd0TqnTZtNX7OqkPX
 ++60KbGwjbNb/1U1jnj9oXGdQssoe2OUL9qbcbc01UjGgHDg16NqYLlJTSV1uEVvmaU9eVgT
 uyuhHQ9qwpsoDag3N0siojJho0P0FDL7yN5y5syKNKmUkF7YcSrEIFRtyGaLYR7WcciQ2Buu
 CYnxbwKo5u7fCkWx5Q9wB7fcPuHc4aU4h75SOmRJjJ4iWtjdbmiiBm87VKuxffgVsmozllKt
 CxFn8HDuH0T1xHe68iJR+Vh80qv1juC1gHe5v9GLE01i6bXNoItz7E+mJcQrUnOGjL7lUb1g
 aKIdksq9fSl5er7brvmoJKXKox6ihnmP6gzlMGzG+Y1PwoUU2SG+emx26fv8VD6TblUlvE7n
 bXVvIreKMgGvKK1HhJZ3pg55xu7Czqr1skTkGcDLFJYYxKHk5bmO0vTLvD5DPawnUyhnTlty
 vvbJLPuGI/NIWLGkLr5fbZy9UpcyA0rwNBb5pJUDKwBIf3pVk/0tdzXEgU5Mwuvw+bgBtV9y
 pkSVn6IAq+cKK/SsFmI6fwzI+SUeYMYtizxJvon6vL0kHM0mVAQcbO00ZYUdny0BvFmLF+YY
 XrojNcBC2AKvg8mQeP0klKCUSRcZ2yzX6I8/D42E4amDYbFRoCwj72NxiK7HpxKaWBcDVCMC
 nDod4uYW/sWdC2SJcphniQCVbe6U4Ahzw2htBfmy7p7KerZ4jMUuYr51Ndp/+3TiQ0y9TtsA
 sSZyW6MQXt7nmcMRzIt3aF/oEl9xUyZ0adimfBYFNpT5+lIUgggL5LcwfZ6B8joWg3dZteJV
 EqmQtK+DD4tSdI+38MBY0dmFtW5jhHD2jKqDKUPm7yKApw06KPc0GLrK8Zz0XaVnJUm2mEvS
 M9IfUurh7R2vyHCGpXO2xGBnqyucowa0TLD9WOfwHDIu1tXBko4c6LXRn0RLmjfodD07VjDT
 Pf6Cr0rNgZK4ciPNqVLbsHklxNBXvi1fJyUT2uvmmv4PlDA47KIaIfwMS1J0CzDBU0snwkN8
 HOCMgYiQCGsvzSaRBF0FFmnT17p+PtztDvvQ0MpygiYYlFJ2L2y9RoYw/ebTqVXlpANuzor4
 xZ1F1e7xNHXQ46DugBoVKZRe9Uw5BFAz22P80RFN5ukKOhLjFMYckwjp0rk2hN2Ip9Nncgjs
 DUhyw8kbeqj0VZGcXu42or1M7uffmn15hW0Q63bwFfT1JCR4KhZrLwatlHitUmNH1Ur93Evh
 /tI13qVoLHDEwMWVbrwVFw2/l50veeeKg887ITQ3GYkCaCwsy+Kj9QoD+whww3mZ95bMbOsF
 Qr7HIsUHZ7qYMAjnVmkalohNetRvPo4NsWnev+uyqmtJftt2jW8gjIDqKB01UCN/iw0eO7V1
 pAKi6WY1wyFVj76ykWhr8nxlqhLYDgTGiy0zi2yQMZrYad/Z5pDK260Mci2xZ0qnZnnVmREs
 lyqHUED2cyBdwCfYhrzx1sUnX4KumeqnS/w7D1ynHl9qquZwTzmyv7ncBsBJ34NQ3Nty0rvd
 8z8r90bX0/gRAEzjweo412yk6hQrYx7Lm/OUQFJdS2wJGZnBO/4iLOZYspeoLwvqy9WU6zob
 leAYrr8pQYKlSLpGi1VwzVtM3mDvpjplhp2hXjVA3FpoHfUZ4kkzBjY/tDRSOB52jsAWTk+i
 DPSQFO7Oo/ttf6UjZbYruG3USqLUYdVbTPiwIyNrmPv72pwBwGllv28l8fPFQk8zD+91tNvE
 y7PqUC4KrL12qLyCulneERsAFK0v9FkF4dluo8xgowAn3kQg9Oe+n9R1S/UP9RBkYj/cGYKQ
 3ZfxNTU/BTi3mVjJ3iAwYu/X3TLhoNGa9S2Kkwf0Cg0/ogeD6id5rZNjAN2r0C+oAaXZuJyy
 HNV7eYl4WVSr+xBnQM3xSWcSuQWAEJRJmrgmhGB9du+rY1WYnqidf67008o2ZidDLaHqxoUe
 Hv9fow+B7F1ppFjMFXJ2Wa16ozgfMLMd9UWnhmVlQrQyelTNJ810PENgHwjcVj6sWckxOlzs
 x1w3Nnupo+LMWRi++SnAwBZHjzze84XvDrqiPAa1uOf1pqzE5MpPjwNX5vvV+m0WGYXvP39K
 wuIVjk1rHSbHqDEASeb6UF7vzTOFYymMzecI3xPiZ1HTQmcIUEXugEMVS821so8DAGyzdbtW
 ER0/DYc4hj/sBQajqpUNx76W3yXlgatbzouTZGZKlIC8hND4kLYK8mX6ORbBDxD89utoVrJY
 kCSeQVERUgIQEiFChi3N7i04djN/8CXA+O/K73FZrDY7aRlVvKPw5vn7IZ64zuWfpGUP3xlC
 fQT1ERcWXQ/EMSP330tRjYQmiSFY8PTjhCm4TE/+sKy6vPmXg7lzYSIDLRWPJNk/BXgxe+7L
 eeOiSt/YRVR0pIDxHnFxbQelAoKiChqdjasF7kNuS/lQ6XXlataSRUcbnU3fPBI5qM40w9Bc
 eXbg9X5nupjjvc0D1pDWXTuncamYcFMKGa4YhePLUCHLrmZbRnWxce/Naq6Raddk6ZSugG8t
 CizF1LlOHKIl2+tHzKmNOxXxBqeNQZC8NW/exNgEi74Sdv8djWxKth+gTYxxPs/gXaccSYwM
 DN/O2BAqLud4TIQ1vl+EG8H7XdjK+SIig6T9e7RJp0RtL1gBSEi06oQwn0/xqAdwWdmArRfn
 zfOqdtqrkDs2r2twz9qS1xkrSpXg4ePsFRKGazf7ZRGYX/e4BQA936QCgxMrNxgXJmn8YVZ0
 MTOkurQbn96/s7Z59ARAYKcfMeOKmYgN1zxFSLZFhAISxasL2jUg0Ebm/aXoDndlJ81p4Kko
 JMTAppcUlq0XqcADUtoBpoaKYpfVTI4i7+LysUP4Cz65DvcQt4Sl4DNUf/aVfz/IjGUpbpJf
 R0FxfX0LtJXfq7y30hvImdzmIOCT0nOVNRKii5sdAk5pANK6ncoCiUR1kzrIiGq4HkIEvj8y
 hw0jQt4euMr3DTh+VE6IhzNviRm1AEakMnshTGXOBv4Nqa2VJoeXyH9q0E1M5W9Rg9vbAu7h
 mRtLjKCTLVU2f8oXGZnkgLD8b5IA+JbS+UQaRwIwNmTZvM1wRFSrTihyUZb5OzDT5x4m11uO
 bylpHEI5AtlY5ZhJ63WPLcP0VFWiYqFuii12qYwxwkZPAAG92bEPGYtsVYDO71uBy2s4ull7
 wrKzz5KYmMBU9IqpfZ280o7PaKH1S22l/ZhLUC4MaS/Iq+TtnLP3ZqKRVM50AUImkVP8KJ5+
 cgmekuQEUsoye3VXzAUNNiKABxactFO8zDNeiDGnejL3YA9a4GgF/KuQeKIqLQ8jUetHQJvF
 IMJuIBJMYOh3wn7N8DuLPslwA8x4Q3tbAGKFvlGexKjlDYBvtGxy4Jx0YBBJzYbR2JnPnPzr
 pjToRUrifzLct43ZHoeWopMYnwyX9e7kigfsX1BCjSz1uMxwhKF5jP3oSGWBz75OZ4rXv6FL
 TFxCZni4zci8oC8k1ne/p7ZIifxMtE0/pf04uQGu96tEfpSQbR7+xPHkZNRQXCnVUbFC9m8K
 5P3bs8natmiTj6QSFu2hzkySo/wOsqgNK6BhUnrSJxSvY3Txj09NMKiXjUfAAs48+sI4ed/a
 BcFbp5+bxPluw43PK/6JAaDzv2kWWGkJTBRSr9UyuDsI/RnzjcmaaeeyTN0XpAnxe222VQAS
 JEDklfVwvP1I8F/VTn6UlBHagLKojRxw2ltLPc1x+Ah6BzNuFgYdTuMcbotIE5DpNF0PVSTJ
 H9xB3c2DwuelY3C5wSr0pgR8jFbktIS1vdK5jy2nJ7FYXqPX7eqr5yd5yghbt89i658K4ruJ
 o2BrpyI2nT6TYPXqQmMTmaQGvxXgZAEJShVRvRTsXo4IsFAspgXrQIJW9skb5lLAaUhpfj+c
 T9gBCIfzgcCSpiNmjcFh7H4k5ndm1+0eYs4PRoPvd0WgNwQFSp/fTkToqSuf5/bm2+NVi4AJ
 wJFqUxu7RgHjYt5YKjG8ZHFSJYEnyZbuf9kejPGDJR4sVDpHCXevVH7Qe6hkqSIwgtThKbw0
 8YSWTZkFFNQge1Rkx1sYJVqIKAL9rXWuzSIPRf++nnxweCmDEFcz8LJa0f/CovV82bxBGlUw
 2APXoJLzDn8FJId2159aaA2tBZBPIavZEfgzzU+woBoGaSoE8exyBA4riBCDwyqCdtaF+Bvt
 hr4XTBkZZ2x4MHuO49TWXNR8ZvbpFJUkUNgKQa2zJNdL4dG5TtaGHBrpiicp5OKRcBFwociC
 5gRI8w5o3rwHrhsM5+LonI3vLGpwXjcrXR0lVaxxDy+H+eVS+ZU5WgXHE19InyTgkQrC+Y29
 27UtFHB9FlpqaMTILmEjUJ1qS01JpFBCTdPnSSjN1V8Q3hAm+pfIaXRNcdbRq92LTSvIR0lC
 fk+30HB2UxummaxNydyrApB5yfFXwRyUSQPhabFkiYRsMa6IXkXVsQMJRMocSrILUq90Rpeu
 14LbUh0Vp0fKtVI4bcW2c1T5MWUDQ6JIC0FVQJrMEoDy/tZlFBKq0yeMXTYBAakZN7Lsxtqb
 YGQpsvvJ/P8qlRpkITi5c0x7LoKXTWGkBesQdnEpom04tCDtkKUdafxG+m9Z2LRCj3Nhgq3n
 rAqE9/B+C2FY1kTEIVz1XdxOcupMmXMJxkTYvtDfyKzNIh/YNRC+KVBYtN8PbwO8ulrDw6GQ
 RXmHMququNHJxDdX2eWND2Pp8q4p4+b9rnBUa74fMXZyn/HSrh2Pp5S7Tj9Bqes1I5V4E3t3
 flxsEh9TAuOKDiP+ezoPRhD/8y+bg3nt5wtEynRBcJ9mXrk3EBAfuITQiu34NIdyZhD7233R
 /4+2U/246VJ77cx0YAs+PhyzNusY6ffLfMPqUh8Hh2dHRln7L0pAW5iVyZUY+QLL+zWc7hfh
 sfrwwzuP4oQ7hDdu+lQaN+dYlrEhtH6EDaXDxpNgAYGrzceaAqazf+M3aFuG46joqDi10Qh7
 kLbTFZOxa1x5YqC5quDpfPGJxrXw78eX6H2R8T15r0yskKW7PcgmfYAYGtwKwGgFeEcUIYay
 AKChegnxCIlCcLDFprk+fheRzQ8nzn6nIt6EUlQEfQRXPKK8YlYgmYkirnBLNRFF8IK0m2LF
 BOiDvoD0SvysG3Ify88302IikGqEgbRpBfsoCR1QDXB1YLmm0tRDPysAFtKGjCuMgl+uS+OO
 wzhsJz2v7405Qc4KD+B1prFmW2/NbdQB8C6KsabJHx+qVsXhYcwRtWH3YEdBMr7JdYa6nZla
 fXCrWislmUSxsUPz5qb+cyT9vjNSDOthq2TsbSNzRhcy34lrRc669u6MerJ6cHMSPOtnTV0L
 W83q07KWBi7rabeplYfNBmQ0UvFr4cNO8lQwXgy0kyOCPELeNso700eE4/BY6lHvjXvIH7ux
 l3ZZdsrVy6Y2j8RH1TvEFA+FrJukG73ucvIkz/X9ThKDsF9fkzunx13Bq08KEQw+B4SwyEZF
 hMKZwzdB7atTUjoNooLU0EfZA/PheP8JfhxhBAvhOr/vqfadokeT+IVO+xYjxKSkVQTAZ8Qv
 aAEAfp9d1Jb6K/Lt13nAonjUeLhkCl4Pvm0T8ZGtMEB4iJ5pFngAUP9tdEav+xI7fLAPrRJa
 pXNos1mukJu5DpVMzdInAA6lRSyF+YVuOHk5NHf9puu8OenEqg3FIB1v1A5AXpzi5zojRUtu
 9bSgq1RQ43ck4X/+ShJIniXqMDf0hJmLvEJJZ7td7FlvSZiRWBWNzcVMNyaZuNpqSJkMDzJ5
 lxLKscNY84Ies/MkhpTkUrnRPdY8c+RSTr6Q89jMssv6WTw0jU895AxB/3h5DGBLpfa91hRP
 vlHgXYkhJfYqeMS2/aXFDkP7CzTdU1u2i3bgcroab647aCWxdrTTV9DAiMmT9IXOm+Z4QL+D
 uutyMewCUXLtYmq3c54LRLKDjm4mKBP2kpVOdZJkT6znj1XF4SvwumQr8Lp8mxc8FtODId06
 xTBXqRZJJRyfxrixIGnQU11By23f8+xFFJmoO2N2uIF+PlzLWP6ZIkGMlQByrng7mFSQBcoQ
 7nz9lqURuMeYtJ6ReiM9ysTtt0mcvJTegHN/tTjtVIq4BguDRUsaaMsozASbUTIkABPGu71t
 LMGlgoAQIt5tEtLSiq7PGMz4SaCVLwA1fLXV6NTq2jPCPVeCRYNUGs2WR6+1ZRwdqH8mPlGt
 jkDhSZhuL0w1DcgQhKguCrqrqZL2DQ6+bj+ui9S3B4NBuiYjSrMDk1OifoQiqJJQXvr6VWmY
 XkKRI/z5qR3Y8Hh/pMm+HMxfVMoeChMDoHCQ2ngyriFBICCqocWnBmWpMDHdqO+NwAWN7Ig2
 VTmRnNn1RPZkgou+2wOCGbFjpdsNMC2PsArwTCtEG7QeQMX469Hh8D2sEYCUOo8bV4yiHUmy
 MWMQTcBAdDeA2tgxBZxcn1KKdgQjH1SX7ltmDuDubNKux0ZcCuBWJrw4ZHexI/JwSVvFIwsm
 T2Q//DZwMp6ijUgktdwpEZmWVwWdurFQ4lpA3Pp0ZxYx/C4bPKo4LlvoG5OzLWnTe9EN8io4
 2yt35t2HESiw+ZGd7JWGOsCwKrLFSKkQnefQuOFby6HmDNraybP
IronPort-Data: A9a23:HMaoe6o1GekL/ZLvLGEZR1LJp0ZeBmKCYRIvgKrLsJaIsI4StFCzt
 garIBmFafuKYGL1fItyaI608UMGu5bVzNFlTVdoqCw8FSoa8ePIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvjrRC9H5qyo5GpB5wFmP5ingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kkPK0o9NZyXlhE+
 NgUJC4kR06q3sK5lefTpulE3qzPLeHvPYUCqjdlzDrDCu0hT4yFSKLPjTNa9G5rwJ8RW6+DO
 4xAOWAHgBfoO3WjPn8aAZI3huaoj1H7cjtFuBSQpKEt5HPUwhA327/oWDbQUoXbGZwLwxnG+
 goq+UzpWAo3F9Wa6APaqCigmdSIlg3reosrQejQGvlC2wbJmjN75ActfV+yvvC9jmasWtdVM
 UVS+yw0rKF0+lbDZtL6VBa5iGWVuwYVHdtWCewzrg+Xopc4+C6dB24ZXnhEadc8s9QxSyBs3
 ViM9z/0OdBxmK+UaUKTxrLLlDm/HSQZM0YrOwZdbQRQtrEPv7oPph7IS99iFou8gdv0BSz8z
 li2QM4W2Op7YSkjiPvTwLzXvw9AsKQlWeLc2+k6dmak6B5pIoukbJav8l/V8bBLK4Pxori9U
 JosxZX2AAMmVMjleMmxrAMlR+7BCxGta2O0vLKXN8N9nwlBAlb6FWyq3BlwJV1yLuEPciLzb
 UnYtGt5vcAIZSXyPPcnP9vpW6zGKJQM8/y1B5g4ifIeM/BMmPOvonA3OyZ8Ikixzhdxyf1hZ
 f93j+71VCdDV/o8pNZJewvt+eRwnHxhrY8ibZX6xA6gyr2QeDaeTq0dWGZinchohJ5oVD79r
 Y0FX+PUkEo3bQELSnCLmWLlBQlWdSBjbX03wuQLHtO+zv1OQzhxVKCKm+x5JuSIXc19z4/1w
 510YWcAoHKXuJENAVzihqlLMeu3A8RMvjggMDYyPF2l/XEmbMz9pO0cbpY7N/1vvuBq0fc+H
 bFPdtSiE8Z/bG3N2w0cSp3h861kVhCg3jyVMwSfPTMQQp9HRi7ywOHCQDfBzic0M3eIhZMMm
 IH4jgL/argfdjtmF/fTOa6OzUvunH0zm9BSfkrvI/tIcXqxqYVBdjD4sdkmKZoqNyfF/yarj
 VeKIBYHpNvip50+38nJiJul8aaoMbpaNWhLE1bL6Y2ZMXHhwVOi5otbQsOkQCv4Vl6oyJ69Z
 O5Q8e7wAMcHkHlOrYB4NbRhloA62PfCuJ5YyV5CMEjQTlH2FI5lHGaK7fNPuoJJ2LVdnwm8A
 WCL29tCPIS2KNHXK0EQKCUlf9a8+6ktwBeK1ssMIWL++CNT15iEWx8LPxCz1QpsHIEsO4Yhm
 eocqMoa7jKksSUTM/GEszt18lqdJXlRQoQlsZAnWLXQsDQJ8W0bQ5LgCX7R2qqtOvFsKUghJ
 wGGiJXS34p8wlXwSFttNHzv89cEu7EwlkFr9nEgKW6NuOL5vd4s/RgI8T0IXgVflRpG9ORoO
 1lUDU5+JITQ3jJ4nMJFYTyIHlhZNUa75Eerml4FvzDbRRPwV0jmDm40CcCS9m83rkNeeTl6+
 umD6WDHCDzFQuD47hEQa2VE9cPxaMNXzRLTvvynE+CuPYgIURC8joCAPWM3+gbaW+Uvj0j5l
 MxW1edXa5yjExUPoqc+WrKo5Z5JRD+qfGV9EOxcpoUXFmTheRa36ziEC2a1Xuhvf/Xq00uJO
 /ZCF/J1dSaV9Xix92gAJKs2PbVLsuYj54MCdpPVNGc2ieajgQQzgq3A1BrVpTENeMpvo/YfO
 4mKVjOlE06sv1V2tVLJjvF5PjufXYFZSiz6hPu44ccYJaIl6etMS3w/4pGwnneSMTZkwS6qg
 RP+V/fW4dBPmYVItKnwI5pHHDSxeI/SVvzX0QWdsOZuTNLoMOXVvjxI81TMYhhfAp0AUY9Ri
 4aLicPGhhLZnbcpUlL2n4uKOLlJ6P6TAstWEJPTB1tLkRSSXPTD50M4xFm5DphSgvZx29KCR
 TbkWPCvdNUQZchR9EdVZwdaDRwZLab9NYXkmg+QsNWODUI7/THcDdb660LsU35XRhUIN7L6F
 AXwnfSkvfJcjYZUAS47F+NUOIB5LHDjSJkZWYXI7xfANVaRg3SGprfGvjgj42uSCnC7TeDL0
 aicTR36LBmPqKXEye9CiLNLvzoVMW1chNchdUdM6v90jDGHVFQ9F9o/CqlfKJ9okX3V7qraN
 QH9ND5oTW23WDlfahzz7ejyRgrVVKREJt79ISdv5E+OLTu/AISbGrZ66yN8+DFMdyD+yP28Y
 8QrkpEq0sNdHrkyLQrS2hC6vQuj7vfbwG8Yv0X8mNb1GBEQHfMB03kJ8M9lS3ncC8+U/KnUD
 TFdeIyGaBjTpY3N/QJIf39TBQFfuTLk1TIzaimTht3Yvu13CcVenebnNbibPqIrNaw3yX1ne
 Z8zb2+M5X2GnHkSsrEuoNUnnel/Dvfj8g1W6kP8bVV6opxcIVjL8y/PceTjgS3iFMNi/4vhq
 wSR
IronPort-HdrOrdr: A9a23:BHZv4K/9/OmEglstmcduk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: 9a23:KonEaGy4UT6mfDlKG/ZlBgUGG+AVfE3Yk07aLmu0BXhAYeO8EH+frfY=
X-Talos-MUID: 9a23:K7JqiAZQQeU4+eBTp2X3qRJrMeZRvP70BF821p4oq+uNDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194165764"
X-MGA-submission: =?us-ascii?q?MDHRj6TcAq/9OTTpKWV1jxyKVZXJqAHHw70nvx?=
 =?us-ascii?q?qVDNFTNP/G+WDzfWV85by8q78cDaMpHA550KCSTEfcTE8PiXRnfQEfEa?=
 =?us-ascii?q?OiuOMIbqGH+8PflrZp0ghRkH7ixHcTR7tkcuDOVhl8hAzWrToOotw2kG?=
 =?us-ascii?q?gF3OF6znWO1vKAhu5V7HbOBg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:22:49 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0429F20BEBD1;
	Fri, 15 Nov 2024 13:22:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0429F20BEBD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705764;
	bh=61FzWbZx8SVE6r33ggD3SgPEq3e2wgbU4/WDXmU67Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DOmpiPqEYKf9HYvH4vBNIcVvfzhSlsEJngIViJ/nyGqO2XrYUeSBMlaznaVp1W2cu
	 ZUg4grO0SjULjCP+Mukp5XmgB/9DjGqaSbQQ7rTaKzOeVo8jg5BmmuuAlRim9GVths
	 B2tZiF5YDxbFOhKnRrq5+IHUzQ7bgR5YW5x81bkg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-10-19aadc34941b@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 10/22] scsi: lpfc: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2014
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-10-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/lpfc/lpfc_init.c      | 18 +++++++++---------
 drivers/scsi/lpfc/lpfc_nportdisc.c |  8 ++++----
 drivers/scsi/lpfc/lpfc_nvme.c      |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c       |  4 ++--
 drivers/scsi/lpfc/lpfc_vmid.c      |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 0dd451009b07914450dc70f2c981b690557c1d8c..12666c4c7986ae0bdfaa5c8f040b4ea0be64550d 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -598,7 +598,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 		  jiffies + msecs_to_jiffies(1000 * timeout));
 	/* Set up heart beat (HB) timer */
 	mod_timer(&phba->hb_tmofunc,
-		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+		  jiffies + secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
 	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
 	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 	phba->last_completion_time = jiffies;
@@ -1267,7 +1267,7 @@ lpfc_hb_mbox_cmpl(struct lpfc_hba * phba, LPFC_MBOXQ_t * pmboxq)
 	    !test_bit(FC_UNLOADING, &phba->pport->load_flag))
 		mod_timer(&phba->hb_tmofunc,
 			  jiffies +
-			  msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+			  secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
 	return;
 }
 
@@ -1555,7 +1555,7 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 		/* If IOs are completing, no need to issue a MBX_HEARTBEAT */
 		spin_lock_irq(&phba->pport->work_port_lock);
 		if (time_after(phba->last_completion_time +
-				msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL),
+				secs_to_jiffies(LPFC_HB_MBOX_INTERVAL),
 				jiffies)) {
 			spin_unlock_irq(&phba->pport->work_port_lock);
 			if (test_bit(HBA_HBEAT_INP, &phba->hba_flag))
@@ -3352,7 +3352,7 @@ lpfc_block_mgmt_io(struct lpfc_hba *phba, int mbx_action)
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
 	if (mbx_action == LPFC_MBX_NO_WAIT)
 		return;
-	timeout = msecs_to_jiffies(LPFC_MBOX_TMO * 1000) + jiffies;
+	timeout = secs_to_jiffies(LPFC_MBOX_TMO) + jiffies;
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	if (phba->sli.mbox_active) {
 		actcmd = phba->sli.mbox_active->u.mb.mbxCommand;
@@ -4939,14 +4939,14 @@ int lpfc_scan_finished(struct Scsi_Host *shost, unsigned long time)
 		stat = 1;
 		goto finished;
 	}
-	if (time >= msecs_to_jiffies(30 * 1000)) {
+	if (time >= secs_to_jiffies(30)) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0461 Scanning longer than 30 "
 				"seconds.  Continuing initialization\n");
 		stat = 1;
 		goto finished;
 	}
-	if (time >= msecs_to_jiffies(15 * 1000) &&
+	if (time >= secs_to_jiffies(15) &&
 	    phba->link_state <= LPFC_LINK_DOWN) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0465 Link down longer than 15 "
@@ -4960,7 +4960,7 @@ int lpfc_scan_finished(struct Scsi_Host *shost, unsigned long time)
 	if (vport->num_disc_nodes || vport->fc_prli_sent)
 		goto finished;
 	if (!atomic_read(&vport->fc_map_cnt) &&
-	    time < msecs_to_jiffies(2 * 1000))
+	    time < secs_to_jiffies(2))
 		goto finished;
 	if ((phba->sli.sli_flag & LPFC_SLI_MBOX_ACTIVE) != 0)
 		goto finished;
@@ -5194,8 +5194,8 @@ lpfc_vmid_poll(struct timer_list *t)
 		lpfc_worker_wake_up(phba);
 
 	/* restart the timer for the next iteration */
-	mod_timer(&phba->inactive_vmid_poll, jiffies + msecs_to_jiffies(1000 *
-							LPFC_VMID_TIMER));
+	mod_timer(&phba->inactive_vmid_poll,
+		  jiffies + secs_to_jiffies(LPFC_VMID_TIMER));
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 4574716c8764fba6d6db103f1f287b7cdb87cebc..4185717f35defbde483b4ff9b1d71c9c3d86a07d 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -914,7 +914,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		    (ndlp->nlp_state >= NLP_STE_ADISC_ISSUE ||
 		     ndlp->nlp_state <= NLP_STE_PRLI_ISSUE)) {
 			mod_timer(&ndlp->nlp_delayfunc,
-				  jiffies + msecs_to_jiffies(1000 * 1));
+				  jiffies + secs_to_jiffies(1));
 			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag |= NLP_DELAY_TMO;
 			spin_unlock_irq(&ndlp->lock);
@@ -1355,7 +1355,7 @@ lpfc_rcv_els_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 
 	/* Put ndlp in npr state set plogi timer for 1 sec */
-	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000 * 1));
+	mod_timer(&ndlp->nlp_delayfunc, jiffies + secs_to_jiffies(1));
 	spin_lock_irq(&ndlp->lock);
 	ndlp->nlp_flag |= NLP_DELAY_TMO;
 	spin_unlock_irq(&ndlp->lock);
@@ -1975,7 +1975,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 
 		/* Put ndlp in npr state set plogi timer for 1 sec */
 		mod_timer(&ndlp->nlp_delayfunc,
-			  jiffies + msecs_to_jiffies(1000 * 1));
+			  jiffies + secs_to_jiffies(1));
 		spin_lock_irq(&ndlp->lock);
 		ndlp->nlp_flag |= NLP_DELAY_TMO;
 		spin_unlock_irq(&ndlp->lock);
@@ -2798,7 +2798,7 @@ lpfc_rcv_prlo_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	if ((ndlp->nlp_flag & NLP_DELAY_TMO) == 0) {
 		mod_timer(&ndlp->nlp_delayfunc,
-			  jiffies + msecs_to_jiffies(1000 * 1));
+			  jiffies + secs_to_jiffies(1));
 		spin_lock_irq(&ndlp->lock);
 		ndlp->nlp_flag |= NLP_DELAY_TMO;
 		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index fec23c7237304b471e58194726ff7932b0010385..64d7060e0d4cb628c74c0fa22ece2b956155c1ba 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2236,7 +2236,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 	 * wait. Print a message if a 10 second wait expires and renew the
 	 * wait. This is unexpected.
 	 */
-	wait_tmo = msecs_to_jiffies(LPFC_NVME_WAIT_TMO * 1000);
+	wait_tmo = secs_to_jiffies(LPFC_NVME_WAIT_TMO);
 	while (true) {
 		ret = wait_for_completion_timeout(lport_unreg_cmp, wait_tmo);
 		if (unlikely(!ret)) {
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 2ec6e55771b45ab70320a9ad1934d5ead2371d4c..b6f19c123e25a00c0eb4444476a7194d6b045824 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9024,7 +9024,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 
 	/* Start heart beat timer */
 	mod_timer(&phba->hb_tmofunc,
-		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+		  jiffies + secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
 	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
 	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 	phba->last_completion_time = jiffies;
@@ -13335,7 +13335,7 @@ lpfc_sli_mbox_sys_shutdown(struct lpfc_hba *phba, int mbx_action)
 		lpfc_sli_mbox_sys_flush(phba);
 		return;
 	}
-	timeout = msecs_to_jiffies(LPFC_MBOX_TMO * 1000) + jiffies;
+	timeout = secs_to_jiffies(LPFC_MBOX_TMO) + jiffies;
 
 	/* Disable softirqs, including timers from obtaining phba->hbalock */
 	local_bh_disable();
diff --git a/drivers/scsi/lpfc/lpfc_vmid.c b/drivers/scsi/lpfc/lpfc_vmid.c
index cc3e4736f2fe29e1fd4afe221c9c7c40ecf382d4..14dbfe954e423acc47d1b1c80160ff193783f500 100644
--- a/drivers/scsi/lpfc/lpfc_vmid.c
+++ b/drivers/scsi/lpfc/lpfc_vmid.c
@@ -278,7 +278,7 @@ int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid,
 		if (!(vport->phba->pport->vmid_flag & LPFC_VMID_TIMER_ENBLD)) {
 			mod_timer(&vport->phba->inactive_vmid_poll,
 				  jiffies +
-				  msecs_to_jiffies(1000 * LPFC_VMID_TIMER));
+				  secs_to_jiffies(LPFC_VMID_TIMER));
 			vport->phba->pport->vmid_flag |= LPFC_VMID_TIMER_ENBLD;
 		}
 	}

-- 
2.34.1

