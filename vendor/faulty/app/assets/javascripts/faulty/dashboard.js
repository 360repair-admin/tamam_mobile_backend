function openAssignModal() {
  document.getElementById("assignModal").style.display = "block";
}

function closeAssignModal() {
  document.getElementById("assignModal").style.display = "none";
}

function submitAssign(e) {
  e.preventDefault();
  const assigneeId = document.getElementById("assignee").value;
  
  if (!assigneeId) {
    alert("Please select an assignee");
    return;
  }

  const errorId = window.location.pathname.split('/').pop();
  
  fetch(`/faulty/errors/${errorId}/assign`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({ assignee_id: assigneeId })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      closeAssignModal();
      window.location.reload();
    } else {
      alert("Error: " + data.message);
    }
  })
  .catch(error => {
    console.error('Error:', error);
    alert("Failed to assign error");
  });
}

// Make functions globally available
window.openAssignModal = openAssignModal;
window.closeAssignModal = closeAssignModal;
window.submitAssign = submitAssign;
