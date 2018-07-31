From: ttabi@nvidia.com (Timur Tabi)
Date: Tue, 31 Jul 2018 10:34:58 -0500
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <alpine.DEB.2.20.1807311716480.7379@hadrien>
References: <CAOZdJXUXp5gmU7_nBftF=5BrSF0u6tygH71uP2knBMJTjfdgkQ@mail.gmail.com>
 <alpine.DEB.2.20.1807311630350.7379@hadrien>
 <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
 <alpine.DEB.2.20.1807311716480.7379@hadrien>
Message-ID: <0be413e6-36f3-9a5b-bb79-29b02546f352@nvidia.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/31/2018 10:18 AM, Julia Lawall wrote:
> I think that if a parameter is not in danger of overflowing and is not
> modified it won't move.  It's not optimally formatting the argument list,
> just avoiding going past the specified number of columns.
> 
> For example, some people may prefer one argument per line, while others
> prefer to pack them as much as possible.  It doesn't try to figure out
> this preference.

That makes sense.  However, when the cocci script shortens a line, the 
lines now look funny.  Also, it appears that since coccinelle already 
has the ability to reformat function calls, it would be nice if we could 
tap into that feature to do a sort of automatic reformatting.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
