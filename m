Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CEC433EF
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 10:23:56 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D31B61050
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 10:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D31B61050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1777474"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 11:23:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E68AE004C; Wed,  3 Nov 2021 11:23:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B893E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 11:23:53 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3Ap1hHAxf8y7d/2r+ai3HDL1fIlGM+pd7LVj580XL?=
 =?us-ascii?q?Ho4xHfqnrxZn+JkuXvawr0AWQG92CoKse0aKW6/mmBTZYp87Z8TgrS99lb1c9k?=
 =?us-ascii?q?8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhB?=
 =?us-ascii?q?oKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmosAndrNUajZZtJqos1BfFvGZDd?=
 =?us-ascii?q?+BKyW91P16ekAjw6tuq8JJ/7yhcvu8q+tJdX6n9Y6k2V6FTAi48M2Ay6s3rtB3?=
 =?us-ascii?q?DQhWK63ABTGgYkQdGDhbc4h3iUZj/riX1tuxm2CmHJsL2Vqw7WS6j76hwVhDlj?=
 =?us-ascii?q?joMOiMj/2HWjsxwi79boA6kqhdizYPYfJ2ZOfxjda7bYNgUR3dOXtxJWiJCDI2?=
 =?us-ascii?q?zYIUAAfQBM+hFs4bzqEADrQenBQS2GO/j1jFFi33w0KYn0+ohCwbG3Ak4EtwJq?=
 =?us-ascii?q?nvUttb1NLoJUeuow6fIyTvDb+lX2Tf754jDbxcsr/aWUrJqcsrR1FIvGxnKgFW?=
 =?us-ascii?q?Up4zlJTKV1uICs2WA4etvS/mgh3Q6pA5vuzWiwNonhYbViIwP0F/E6Tl5z5gvJ?=
 =?us-ascii?q?d2+UEN3fN6pHIVQuiyEKYZ7Tc0sTmVqtSg1yrAIuYO2cSkWxJk7xBPSduGLfoe?=
 =?us-ascii?q?H7x/+SOucPDh2in14dbywmxu/7Eqtx+vhXce3yFZHtjRJnsTSunwXyRDf9MqKR?=
 =?us-ascii?q?uFg8kqjwzqDyh3f5vlALE06j6bXNpAsz7AqmpYOrUjPADX6lFv2gaKQa04q4PK?=
 =?us-ascii?q?n6/79bbXjvpKcN5F7igX5Mqk2n8y/Bvk4MhQUU2mV5+uzz6fv8lDnT7lSj/02l?=
 =?us-ascii?q?LfWsIzCKMgFu6K1HRVZ3pg95xu9FTuqzdYVkWMaIF5YYB6HipLmO1DKIPD2F/e?=
 =?us-ascii?q?/hFGsnS9syf/cJL3hAYjNLmPZnLnuebZ95VRcyAs1zdBQ/J9VBK8OL+npVkDsq?=
 =?us-ascii?q?tPUFgU5PBCsw+b7FNV90ZsTVn6IAqCFLKzSsESF5vkvIumJfI8aoizxK/kj5/7?=
 =?us-ascii?q?0jH82g0URfaez3chfVHftFfNtKESxYHz2g95HH31ZkBA5SbnPgUeBTCUbSnK8R?=
 =?us-ascii?q?aM66XlvLYu8DprYAK2pjqaA2iiTAZBcIGxLXAPfWUz0fpmJDq9fIBmZJdVsx2R?=
 =?us-ascii?q?svVmJTog8yVexuQW8x7c1doI8HwUHuJil2NUnv4U7ejkt+DYyA8nPigmw?=
IronPort-Data: =?us-ascii?q?A9a23=3AK0EENa90oZO0c6+VX/9TDrUDO3yTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUongjdVymtLWGCAOP2OMzCmKdByO96+/UkP78fUm9BnQXM5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOi+xZVA/fvQHOOlUba?=
 =?us-ascii?q?fYnoZqTJMEU/Ntzozw4bVvaYz2bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57+dVAWBKHfN06ChxK6WYD420IE/HZtlP9kcqNFAatUo23hc9RZ7dxXtoGrD?=
 =?us-ascii?q?yotMLfNnus1TBRSVS1zVUFD0OaYfifj7pf7I0ruKiawnaw3UinaJ7Yw8eF8CmB?=
 =?us-ascii?q?m7u0dMDlLbxaZhuvwzqjTdwXGrtB7eZKtYZdG7ykmlSWDWK5gG82YGrGRsIceg?=
 =?us-ascii?q?SNv0+lQOd3bQeYZTRtmSizbYyFVHGkWLYZnxLLwwiHrG9FDgFeSuLZx/GXZigB?=
 =?us-ascii?q?8uIUB+eH9IrSiLfi5VG7Bzo4Hw4j4Pv3eHNmY1CbD7X+mwOPC9c8+cOr+C5Xgn?=
 =?us-ascii?q?sOGQnXKroDQNPHSfUS2q7+1hyZSnvpBflcM9HNGQbcarSSWoxqUY/F8iGGJtFg?=
 =?us-ascii?q?QVrK81sVSBB6lksLp3upSOoTIovOtpjDrWA/aiAHGDmO0ou4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AIgYsp623dxPlFnMJKJqnEgqjBKckLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SK2lfq+V98jzuSWftN9zYh8dcLK7VJVoKEm0naKdirN/AV7WZniFhI?=
 =?us-ascii?q?LeFvAG0WKN+VDd8lXFh41gPPBbE5RDNA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0C4CwCmYoJhhwsR49RaHgEBCxIMQIFbA?=
 =?us-ascii?q?YE5AgEBAQGCNjoxhEeIJYZHgXeLOYcHihaBewsBAwENEgErAQIEAQGCDYVKAh0?=
 =?us-ascii?q?HAQQ4Ag0BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDUABEAGBYyKEFRUIA?=
 =?us-ascii?q?QERJzQCJgJsCAEBgm2CVQEDM61AgTGBAYIIAQEGglqBbR8sIlGBWgmBECgDAQE?=
 =?us-ascii?q?BAQGFdxNBh20QgVVEgTwMgkeGAIJLgmWPbBOVC6wfMweCC4EsBYE0C4dylS4GF?=
 =?us-ascii?q?C2VZA4GkTCWDqB4hTKCD4FmMxokgzhRGQ+NeAEnGYQMiixAMzgCBgEKAQEDCYV?=
 =?us-ascii?q?HAQGBcYlxAQE?=
X-IPAS-Result: =?us-ascii?q?A0C4CwCmYoJhhwsR49RaHgEBCxIMQIFbAYE5AgEBAQGCNjo?=
 =?us-ascii?q?xhEeIJYZHgXeLOYcHihaBewsBAwENEgErAQIEAQGCDYVKAh0HAQQ4Ag0BAgQVA?=
 =?us-ascii?q?QEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDUABEAGBYyKEFRUIAQERJzQCJgJsCAE?=
 =?us-ascii?q?Bgm2CVQEDM61AgTGBAYIIAQEGglqBbR8sIlGBWgmBECgDAQEBAQGFdxNBh20Qg?=
 =?us-ascii?q?VVEgTwMgkeGAIJLgmWPbBOVC6wfMweCC4EsBYE0C4dylS4GFC2VZA4GkTCWDqB?=
 =?us-ascii?q?4hTKCD4FmMxokgzhRGQ+NeAEnGYQMiixAMzgCBgEKAQEDCYVHAQGBcYlxAQE?=
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="1777473"
X-MGA-submission: =?us-ascii?q?MDHOhVYxYAMmVBhzCHiZDFhQsnOWtJS64qBkVb?=
 =?us-ascii?q?iR2eqfXM4gOCuj7v0OaL45IgpAZ8tMtTLW0kDW8fay8HcGvy2xpVbT5z?=
 =?us-ascii?q?7+vWtP9+WUi6xgem1iidhkz3v6h1AaiuiqEPYybDCfdKmbvSIVoUZk2u?=
 =?us-ascii?q?S2YZOjlXv4I6ZjVO+01RE3DQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 11:23:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635935031;
	bh=9uhnaUJr5qhQTBINiVKHujjCQKsM/g5z9GHMHaBzQOQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=N3TPrFRD6FSWVmnKCZSq5Rn+2c+WVEVmKXttbi1rqajLqs3swLyqzuyPAVY8gCr5i
	 STIsGgf3HqThqBYeQeVM0Ce9mHOqxOAZsS+duCN7uycz/eSwm+hxNz7Qh1IAZcSlVc
	 A8S50q8Lh2JMJUfKtlyQ/caux2kwm0yB7CYMybPs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.102.25]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GJ0-1mtk0v2sMI-00CeXz for
 <cocci@inria.fr>; Wed, 03 Nov 2021 11:23:51 +0100
Message-ID: <b2aa6f7a-2169-143c-59c4-bab1830126bf@web.de>
Date: Wed, 3 Nov 2021 11:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8J7t8nO6IG1V6ziL0obG3LyBpkqA3b5JtQl63YFp/lKYHhKAUr4
 7KG/C+Spms4KqMgcjPZ9BhaOVhMG8c/8kIHvH7e2hCzgZvpxtY+fqoyydGlIbFjdtZ1xMWf
 ZP+3RMv5NELUj/w6dkvlzpB9SiEsRAESRg7dwCaMRb0jNxlhfB4KYj9ecnKQGreh5u7zSgg
 Swm2311xUGHxu63Pldd3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GzV0KKbkds=:qgU5IQT25CqpA6bqUhp0JQ
 ySlm4LvRi61iHfElcL1Yi1cMt26pzlQPCBraF6K9/GidZYSgDv/YRqJRpx3GscVDW4mEyr/jt
 jJL+L8vQ96D7ORd5BWDJpbi3/ao3SbxpnSdNrs6GYjPFjeqbvmr7zSMpY3fNjmKsbAsw6WkbJ
 HOOMeqVw63tfurFWdcJfjoy/6OdqMGlKfZZORgh20CkrnxrmVD8+//TjmwHVEmnQ2HvySq4On
 aWi1xF+MsREt0V0N6WMQcAWgH0EpddsXamfG2OhppxyGME/Bgx1uoh0iNfUyGTKk032o8bh3b
 MGTioe9rOuwxQTgWwyg5gEhyojrCsda5VIQb7WudCwKthwHsXfeH1ki1H60FhnsQtqGyhDLbd
 fQISQNmpHt3ByyejeEhbOz1QNcVXOth7tOaBylJY+9Nkr2tar9vR6ixqdsgLGEyF3z1t9FXSn
 61uVif58kn9+b+pBitU+kYqzDesgVQLkKsJcUwKSiHyi3d5GO2XuJGjPZcaWAZXCf+setLzvu
 UwawDIaOsHL5Ljr5sk5PdSwQnaTSFREgdoddpkrZRMY/SBcGJnpq139PyJ5xW0GB1ixF0yxdB
 0mUICL3PBFVskPZVFHaCVR4vT+u5cA/HEREr6NrdpuFEZ6CPopCha7ie6gfjLyUekUk/hCPxC
 A6bkw5RS6/tNSt1UVXaF2SBhegMaeGNbwqYvYJaCjYeAfgYYgyjNz3xtDkB/p3A3LvsXI5TlO
 rr6WduhrYnvBKl3/3G801IUfRiZ2+Ze5OBGb8pVMWPmt//1Ydeu8IDd3m6XHX1knPHKxl6aOV
 a+xEsQBH3VUhuh1/ly8yVoQDgWk0IGvlNwAZhkUd9h8Ab0XlQOFtTlDDDccdV74nBaxo/5kpT
 yBOYu023EL9SXQuVl09cjmcLO52uTrzE0L6T3KXaAGtIetUqnz6+rx5wJQlM2PkTvgLMDOItQ
 jf4n+YQ0c4jaARDQDOhrAvojCaHVZnMDyMVaKFC834HUAYhVXCaURnUexlTcKABEIU8GQ0EHw
 4IjIEJ5e49vatircFz1T6ZXghdfiXGECPD5fHOUncEZ3U5B+nLqtNCXWDrC0C61aj8XN2niHa
 mnLjJDzAW/hh8Y=
Subject: [cocci] Checking parts of binary computations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 57
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/b2aa6f7a-2169-143c-59c4-bab1830126bf%40web.de>

Hello,

I have tried another script variant out for the semantic patch language
according to the software combination =E2=80=9CCoccinelle 1.0.8-gf4ba8df=
=E2=80=9D (OCaml 4.11.1).


@display@
binary_operator bo;
expression left_ex, rigth_ex;
idexpression idex;
@@
*idex =3D left_ex bo rigth_ex;


[Markus_Elfring@fedora Probe]$ /usr/bin/spatch --parse-cocci /home/altes_H=
eim2/elfring/Projekte/Coccinelle/Probe/show_assignment_to_idexpression_fro=
m_binary_computation1.cocci
init_defs_builtins: /usr/lib64/coccinelle/standard.h
minus: parse error:
   File "/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe/show_assignme=
nt_to_idexpression_from_binary_computation1.cocci", line 6, column 16, cha=
rpos =3D 98
   around =3D 'bo',
   whole content =3D *idex =3D left_ex bo rigth_ex;


Can such a search pattern become usable?

Regards,
Markus
