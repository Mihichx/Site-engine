const modal = document.getElementById("dynamicModal");

function openModal(fieldsList) {
    document.getElementById("modalTitle").innerText = "Добавить новую запись";
    document.getElementById("rowId").value = "";
    
    fieldsList.forEach(f => {
        if (f !== "id") {
            const el = document.getElementById("field_" + f);
            if (el) el.value = (f === "category_id") ? "1" : "";
        }
    });
    modal.style.display = "flex";
}

function editRow(data, fieldsList) {
    document.getElementById("modalTitle").innerText = "Редактировать запись #" + data.id;
    document.getElementById("rowId").value = data.id;
    
    fieldsList.forEach(f => {
        if (f !== "id") {
            const el = document.getElementById("field_" + f);
            if (el) el.value = data[f] || "";
        }
    });
    modal.style.display = "flex";
}

function closeModal() { 
    modal.style.display = "none"; 
}

window.onclick = function(e) { 
    if (e.target == modal) closeModal(); 
}