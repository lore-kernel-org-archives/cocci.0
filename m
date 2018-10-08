From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Mon, 8 Oct 2018 21:02:58 +0200
Subject: [Cocci] uses of Coccinelle
In-Reply-To: <alpine.DEB.2.21.1810070800560.2347@hadrien>
References: <alpine.DEB.2.21.1810070800560.2347@hadrien>
Message-ID: <76571dfe-7c74-998e-25ff-40008cc03a55@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

On 10/07/2018 08:02 AM, Julia Lawall wrote:
> It would be helpful to me to have a list of some things that Coccinelle
> has recently been used for.  A one sentence description, would be quite
> sufficient.
I'm using coccinelle exclusively on Wine.
Not doing anything fancy now, just replacing open coded ARRAY_SIZE() (as
that is a late addition to Wine there are quite a lot of those.
Here and then I rerun some of my older scripts, basically janitorial work.

If you're interested in stuff from the past:
- COM cleanup (coccinelle script generating coccinelle scripts, one per
COM interface).
- Open coded *Rect*() function for the Win32 RECT type.


bye
	michael
