Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA10C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TUv2AO82Kbtf6vkDhYyVL1MFul+Thlby79ZwQPN1pf4=;
  b=PkFYpZJyPb52sjGlMxY8fzeuvR8Pr5UWD8Ik0UB2HW+bK+f2JXSaukeU
   5o9CulYCRS3ebL7mKuD211EYJ6ZVgXwhM9ajwhDZmdgF0BwV3mWzg1lta
   YvqQ+ttTXtFeNP2bOYZM4bbbcYMnISxJf/jqjEM4XWM9hsQkiohaAyvKT
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207529620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 16:54:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8AB1E0D1E; Mon, 10 Feb 2025 16:54:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 14526E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 16:54:42 +0100 (CET)
IronPort-SDR: 67aa2141_PqxiW/2OMVEAUd/uyEzN+ormpU+BBKHuK9wpNykJhqNMwIG
 7jEVT1IJVMh+ezSKTwPw0bcbXe/ldYLOZnMGeeQ==
X-IPAS-Result: =?us-ascii?q?A0FvJQDBIKpngAMP49RagQmBVYJCgVczBAtIhFaPT4F0M?=
 =?us-ascii?q?IQ7hzuHU4xJDwEDAQ1BAQIEAQEDBIUAAosEAh4HAQQ1BQ0BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHRAEBAQIBIwQZAQERJgEECwsaAiYCAlYGFQEBgn6CMAEDDiMHs?=
 =?us-ascii?q?Gl/M4EBggwBAQbaXB8sIleBZQmBGi+Fa4JjAYpiJw+BVUSBPAuCRzE+iB6Ca?=
 =?us-ascii?q?YIzhEdnmlSJL1J7HANZLAFVExcLBwWBKUgDgREjD4EUBTRBOoINaUk6Ag0CN?=
 =?us-ascii?q?YIefIIragQFgS2CO4RDhEuFWIISgWADAxYSAYIxcHgcg1R5HUACAQttPTcJC?=
 =?us-ascii?q?xsGPZ83zi00B4I4gWaBYwyfXAYTL4NwAZNSDgaSe5h8qS6BfyKBXDMaJE+CZ?=
 =?us-ascii?q?08DGQ+OWYN1xBFCNTwCBwsBAQMJhUYBAYsZgUsBAQ?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNhq7N/eu8cRVZG8FQ==
IronPort-Data: A9a23:qy2eT6Mm4By3bsHvrR1zk8FynXyQoLVcMsEvi/4bfWQNrUor3zcDz
 zNMWGqAb/vfNmv2Kdt3PIrg/E1UusPSzdU2GnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQTNNwJcaDpOtvrZ8Us35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXgSH/I3P8tF3hrftESoOBGXGRC3
 KcXfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBf6iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yGvLW0J+QnEzUYxy3Ljyg9A273zDOPYQNDQadlfxEK6o
 EuTqgwVBTlBaIzHkmramp62vcfBlir/VYg6Bry9/ORjxlyV3G0aThMMPXOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVWhqlvDibsxRaV9c4//AGBB+l7JHQxxmTRXM9E30dYoYghZIzSRVx2
 Qrc9z/2PgBHvLqQQHOb076bqzKuJCQYRVPugwdbF2PpBPG8+ekOYgLzczp1LEKipvHYcQwcL
 hiPqzUiwaoeh4gH2s1XHGwrYRr9+vAlrSZsuG07u15JCCsnP+ZJgKT2sjDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cb2aN2AQyTsF6rWX1k5JGQWy2yG4hTKuOGplUEQIFn
 GeP4lMBjHOuFCD7NP4sPepd9exwlfC7RLwJqcw4nvIVPsgpL1/YlM2fTU+X2Wf22FMh+ZzTy
 r/LGftA+U0yUPw9pBLvH7l1+eZymkgWmzmPLbillUrP+eTFPha9F+xaWGZim8hjvMtoVi2Po
 44Hb6NnCnx3DIXDX8Ug2dRPfA9bdCFiVMmeRg4+XrfrHzeK0VoJU5f5qY7NsaQ890iMvraYp
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy1EhCeUGANRKI4Hw3t0f34TzTr7xgLX3aWt9Nhg
 riO1TH7YJskRiY5Pvn3dcCA8lKVlloekdJUQEHnDIRyekLt0Y4yMA33rKY9DP8tICX55Amx9
 lipEyZDgNLSsaoZzcLsh53Yn7y2EuB7IFVWL1Pb4ZmyKyPe2Gipmq1Eb8qlYhHfUznS1Ji5R
 OAI0cz5DuILrGxKv6V4Dbxv66A0vPnrhr1CyzVbDGf5VEuqBpxgM0u585F27IMV/YBguCyyR
 k6r0ftZM+/QOMraTXggFDB8ZeGHjfwpij3e6MouG3rD5Qh1waGmVHtDNBzdmQ1fK7pIaLke+
 9kDg/JPyQKDiUsNCO2k3wR07GWHK0ISX5o37q86BJDZsSt161VgT6GFNArIzsChV9F+PHMuA
 Aeov4vZprEFxkP9Y3s5TnfM+uxGhKUxghNBzX5cBlKFnuvE2/wF5zxK0DENVg8O5A524+FyH
 WlKNkNOOqSF+QlztvVDR2yBHwJgBgWT3E76238lsXL/dFa5cFDNIEkWG/e/zGpA/01yJjFkr
 aylkkD7WjPUTeTN9yoVW389jcf8TNZ0pzbwqOr+E+urR5AFMCfY2Imwbm81qjziM8M7pGvDg
 cJIpO9QS6nKBRQ8kp0BKbux9OovEUifBWl4X/te0rsDHjjcdBGMyDG+ER2NVf0XFcPa032TK
 pJIHd1OZSScxSzVjzE8BIwwGZFWssMtxuI/fuLMGTZbnZqZ9iFkobDBxBjY3WULeehjoew5C
 4HWdg+BLFCuuGtpqzfNgvVpamucSvsYVTL4x9GwobkoFYpckeRCcnMS87qTvleJOlBZpzaSs
 AfyZvLV/ddD0qVppZPnSY9YNjW3KPTydeWGyx+yuNJwduHyMd/CmgcWi1v/NSFEFOE1d+Uss
 I+Sovvb4VjgvotqY1vGmpKEKbZF1f+yUMVTLMjzCntQxgmGZ+PB/DoB/DqeBaFSsdYA+PSie
 RS0WPGwefERRd1Z4n9fMApaMhQFDpXIfrXSnjy8o9uMGyoi/1T+dv3/zkDQbEZfaiMsEL/9A
 FWtu/+Ru/ZpnL4VDxoAX/xbE5t0JWH4YpQfdvrziCK5C1e5iVbTq5rgkhsdsQvwMEemK/qjw
 5z5RUnZTi+Q6ZH4lIQT98Q4uxAMF39yjNUhZk9XqZY8lzm+C3VANugHd4kPDpZPiCHpyZXkf
 3f3YXA/DTnmFyFxGfkmDA8Pgi/EbgDPBjv4GtDt10aTdjvwG46KRrdsnsulD7GaZRO7pNxL6
 /lHkpEzAvR16o5kT6Af65RXRM95k+jCyCtgFV/VyqTP7tV3PVnO/GNsFkxBWEQr1i0LeFrjf
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:xg9IJqE2rIGBh9vQpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:P07qfm17pbDoI/g33XXR4bxfPPshVmLXj2zpfgzkAzxveeCQRXbL9/Yx
X-Talos-MUID: 9a23:3/tYtQSi+TypZBUZRXT2tDdhBcxt/ZiXBXoBy7kasZOAFypZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="108689939"
X-MGA-submission: =?us-ascii?q?MDG53l4txSxQHH2XKalbPn3KC/8M/pwPF0Be4f?=
 =?us-ascii?q?6uldXDojFtdH4ff6+X+EoYPt71MMCN1HRO3uxql+RM/HPu5CDrBK8pUq?=
 =?us-ascii?q?YAmdANkq4kiK6z/8x2Fh+qPNtDMmdWJYpUBNoVzdPsrKX6tRP8w0Pyna?=
 =?us-ascii?q?o4NbZVPsIJojt1wrlMOB6m0w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 16:54:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739202879; x=1739807679; i=markus.elfring@web.de;
	bh=TUv2AO82Kbtf6vkDhYyVL1MFul+Thlby79ZwQPN1pf4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aNg1+kf4ii0/TJjtNCY9Amr4eJ6F1GVVgLBMHNhKmKxPqg8tXRCH+CWk5kdSLiMW
	 WN+tZ7WR0nSkKv8moAqbCF9vlZ8ZkI5jhy4+nnJERSJwe6U+rlInmrQmMkjiCr9nU
	 F9xnSsLXlWIqnpN0MSxL2U1wf2dEsy5/T8LnxF5OXz3jmivQrYcQHtyjrsxEzEs8c
	 V+qfTgygkIg7g1tMuX6UCjP9HC7DDUKmhJ9vkbBU92gUBa/BKXXkJC36LVLwsn7Py
	 sUrAyoe6tQFFax0IltntcW8vniaAZGhI1KzCKi9/+91qfERKGY6MInplezWnIPBq8
	 BjbFu8jqPuc87GpVnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SPD-1tFvjk0UAB-00zUXx; Mon, 10
 Feb 2025 16:54:39 +0100
Message-ID: <0e131286-d14d-4672-a476-80352111b93c@web.de>
Date: Mon, 10 Feb 2025 16:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
References: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr>
 <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr>
 <1948830352.8646779.1739186619092.JavaMail.zimbra@inria.fr>
 <6a8d84cc-8bff-d68d-5d7b-fd567627149@inria.fr>
 <1932675609.8662032.1739187744210.JavaMail.zimbra@inria.fr>
 <b0221fbf-5e28-65c8-b5e9-9440e86bcd45@inria.fr>
 <1507041832.8850908.1739198923533.JavaMail.zimbra@inria.fr>
 <6c99f67f-11ed-c3c1-948a-155e22667e24@inria.fr>
 <1328834805.8860973.1739199290076.JavaMail.zimbra@inria.fr>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1328834805.8860973.1739199290076.JavaMail.zimbra@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h0hxLWNYbm4XNIxfvgcB+FvlYNhTwbZPDhFyMPL+IXZ4guKnQZs
 eFOPeW4x1DE/h5GoTkrJFx0bOEyHezvIJwJlwYE3xtMKdShooCWWWAR84C58tDs0OpSpN77
 KZsug/Vl4wXMS1eHu/gz/hyYvniyJ10pW1sI2Xh1OKkD2kd/79ZMTyP7yQapvMql4ZLofRM
 y3wNZTfJ3e5ETpIQFST4Q==
UI-OutboundReport: notjunk:1;M01:P0:PTgZr/D99PI=;eAGuXcEnF45JpCUiEGQBSsCltih
 BL23bSbYG9ZTFmFfTOHCMtQg7uUiKte7dygIEQ/7FkjS8tge5ymZU8RMn6vpY7enx5xqtJ4Zu
 cala+WEzlFO2xVQNGSzFCyng6qRb2wD8wU6GrJv9l0zmXlVNRMpcHgsE5/qwJVJl11inzR3he
 WBIuhLOp6UxkWKmoh746F5l0hoLoWOMSerAk3+c8937GpgLMK+g4/2cf+g1CvA3eAjmQ5/hXl
 +dEumsZit8g0OLq1rxIpUMw16Q1bNMN3A80FVNZyCu4tpCjrgH+tQ0uS/V41R4BBik+79dB7q
 9t8vZvQ3YK2rrLdU/nbWGrUFd18V/fM0Oyvu8op87WVE8nEMGo6TRsac0//bi0eo0MEZwRznG
 q50ddoXIgSvrB5LQ46VBnjSsarOvQRFoibjXD+aQdgTWL/JSI7U9X9U6eSvXBruwbq/I8vKc4
 MNaaFbeKEW2s6Imvl1ijr2pwrgyVd1+YTjk6utezHZh50KfnnY2X7g3AoyLVz+7GAXOQn0/QW
 /uKFZzm2YJVLh6Td4TYk7Z9WhNmU683yu78pW0kTxkQ68slUKwpmx2fPukBHBTzuXjEceXrnv
 3snHvgzhxmb9PMH88pRKbFTEqKoYDV/Wx2V0GTiVdQAF//I8ZESd/heAlYGv4eIflHbUG53G7
 Q++HsNH5irDr1BExxAfW9wGWQWWlYFcTS2Z0onKz1gdBMz3pdENfo1vu9qo5bQSboYlen3fSt
 ucCC268XjjXsUA3hT+vXy6JX+EqNluEV5yJ+/qRvjGvBK/CMxxH4daOFh7DKbhigjhSK8ASD1
 mDkFDOE504xtDcBqEwgGxIUEk2XZnTWEWZ5lhCKv4hHWiV8BurebKA/bgSO13dxA9TIFVMdDW
 uU41W9wccUMb8S3HL3eeAa0i19u7oAEh2prKRHYJ2MR19j9MwQiu3m5BJaDmlRU2feG6hjQ3O
 2t+E2ib54g1q2mq55iDSJpM6DbhRzY8n6Nm9/yWWqKUTUrQ9YMLAW7OylaOq1Su3LRSX2PhAW
 Udc48W6rvBRDbY4yNc0qTyZbpEn8npCzazfnLioi+7h4jXIg73+14cMe94y7nI51GchSyVOlf
 Uq0N9fmmcfegiC8+R801z0GAPYQTUupR7943iJ35Kz5UQixRS7CwBGayXcEVwsMpYqoEFpn4u
 9uK0Qog1aSwqVtaL76q4EpW61bAX+fEZ4F/jqvF4hhUR23XJlJUlLM3XURpZ64szjSLQN9rWB
 5Ty5yFuV6nD8t1HjAmqTCDDTxGelo5POISx+8LgYsVy9kquA9CXl6wuezLMeP078hm4w0+dXZ
 DtA6/sXWeFwyrQ2Z1QuqB6LT0iL3d24+oO8fo50H42a7ngYHEqjVCxc5SvP63xRQDz84NXnku
 BUXO43Oe/3zbdh5kiA5gZF/45WXP6vQBI6oUPvESxr4ojgmg2eleMd4NiEsv/lorED8xIdd8o
 zhUccPhMHIcAWoiT/uZfxFMyAHH8=
Subject: Re: [cocci] Creating function definitions from function pointers in
 a struct with coccinelle
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2397
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/0e131286-d14d-4672-a476-80352111b93c%40web.de>

> I actually meant this
> ctx->ops.my_function(id, data);
>
> ctx->my_function(id, data);
>
> with the intention of picking up my_function and the parameter list.

You can choose metavariables as needed for function calls.

Examples:
expression ctx;
expression list el;
identifier ops, my_function;
long id;
struct my_info * data;

Regards,
Markus
