<script>
  document.getElementById("reservationForm").addEventListener("submit", async function(e) {
    e.preventDefault();

    const form = e.target;
    const data = {
      name: form.name.value,
      email: form.email.value,
      event_date: form.event_date.value,
      guest_count: parseInt(form.guest_count.value),
      message: form.message.value
    };

    const BASE_URL = window.location.hostname.includes('localhost')
      ? 'http://localhost:8000'
      : 'https://api.basilbartending.com';

    const res = await fetch(`${BASE_URL}/api/reservation`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    });

    if (res.ok) {
      document.getElementById("responseMsg").classList.remove("hidden");
      form.reset();
    } else {
      alert("Something went wrong. Please try again.");
    }
  });
</script>
