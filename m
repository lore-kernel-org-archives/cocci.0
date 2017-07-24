From: bp@alien8.de (Borislav Petkov)
Date: Mon, 24 Jul 2017 12:34:36 +0200
Subject: [Cocci] [PATCH] EDAC: remove unnecessary static in
 edac_fake_inject_write()
In-Reply-To: <6698a3ad-bb52-7297-a10b-818304c96d38@embeddedor.com>
References: <20170704214440.GA9462@embeddedgus>
 <20170717083946.GB23129@nazgul.tnic>
 <alpine.DEB.2.20.1707212205410.2232@hadrien>
 <20170722063602.GB2050@nazgul.tnic>
 <638a94de-5eb4-eba4-7c28-4b4eb4bf8dbf@embeddedor.com>
 <7209d11a-c2f7-ca65-94d8-56f996133013@embeddedor.com>
 <alpine.DEB.2.20.1707230654200.2068@hadrien>
 <6867696d-edd1-3d21-eb7e-af68e087750a@embeddedor.com>
 <alpine.DEB.2.20.1707230749080.2068@hadrien>
 <6698a3ad-bb52-7297-a10b-818304c96d38@embeddedor.com>
Message-ID: <20170724103436.GA23386@nazgul.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Jul 23, 2017 at 01:25:56AM -0500, Gustavo A. R. Silva wrote:
> Lesson learned, your original script should remain as is. :)

Ok, then please send Julia's script as a separate patch and then in the
EDAC patch, reference the path to that coccinelle patch so that it is
clear what has been used.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
