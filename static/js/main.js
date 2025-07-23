/**
 * WAUU LMS - Main JavaScript File
 * Handles interactive features and UI enhancements
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // Initialize tooltips
    initializeTooltips();
    
    // Initialize file upload preview
    initializeFileUpload();
    
    // Initialize form validation
    initializeFormValidation();
    
    // Initialize auto-dismiss alerts
    initializeAlerts();
    
    // Initialize loading states
    initializeLoadingStates();
    
    // Initialize character counters
    initializeCharacterCounters();
    
    // Initialize confirmation dialogs
    initializeConfirmations();
    
    // Initialize responsive tables
    initializeResponsiveTables();
    
    console.log('WAUU LMS initialized successfully');
});

/**
 * Initialize Bootstrap tooltips
 */
function initializeTooltips() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
}

/**
 * Initialize file upload preview functionality
 */
function initializeFileUpload() {
    const fileInputs = document.querySelectorAll('input[type="file"]');
    
    fileInputs.forEach(input => {
        input.addEventListener('change', function(e) {
            const file = e.target.files[0];
            const preview = document.getElementById(input.id + '_preview');
            
            if (file) {
                // Create preview element if it doesn't exist
                if (!preview) {
                    const previewDiv = document.createElement('div');
                    previewDiv.id = input.id + '_preview';
                    previewDiv.className = 'mt-2 p-2 bg-light border rounded';
                    input.parentNode.appendChild(previewDiv);
                }
                
                // Show file information
                const fileInfo = `
                    <div class="d-flex align-items-center">
                        <i class="fas fa-file me-2"></i>
                        <div>
                            <strong>${file.name}</strong><br>
                            <small class="text-muted">${formatFileSize(file.size)} - ${file.type || 'Unknown type'}</small>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-danger ms-auto" onclick="removeFilePreview('${input.id}')">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
                document.getElementById(input.id + '_preview').innerHTML = fileInfo;
                
                // Validate file size (16MB limit)
                const maxSize = 16 * 1024 * 1024; // 16MB
                if (file.size > maxSize) {
                    showAlert('File size exceeds 16MB limit. Please choose a smaller file.', 'warning');
                    input.value = '';
                    removeFilePreview(input.id);
                }
            }
        });
    });
}

/**
 * Remove file preview
 */
function removeFilePreview(inputId) {
    const input = document.getElementById(inputId);
    const preview = document.getElementById(inputId + '_preview');
    
    if (input) input.value = '';
    if (preview) preview.remove();
}

/**
 * Format file size for display
 */
function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

/**
 * Initialize form validation
 */
function initializeFormValidation() {
    const forms = document.querySelectorAll('form[data-validate="true"]');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validateForm(form)) {
                e.preventDefault();
                e.stopPropagation();
            }
            
            form.classList.add('was-validated');
        });
    });
}

/**
 * Validate form fields
 */
function validateForm(form) {
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    
    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            isValid = false;
            showFieldError(field, 'This field is required');
        } else {
            clearFieldError(field);
        }
        
        // Email validation
        if (field.type === 'email' && field.value.trim()) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(field.value)) {
                isValid = false;
                showFieldError(field, 'Please enter a valid email address');
            }
        }
        
        // URL validation
        if (field.type === 'url' && field.value.trim()) {
            try {
                new URL(field.value);
                clearFieldError(field);
            } catch {
                isValid = false;
                showFieldError(field, 'Please enter a valid URL');
            }
        }
    });
    
    return isValid;
}

/**
 * Show field error message
 */
function showFieldError(field, message) {
    clearFieldError(field);
    
    field.classList.add('is-invalid');
    
    const errorDiv = document.createElement('div');
    errorDiv.className = 'invalid-feedback';
    errorDiv.textContent = message;
    
    field.parentNode.appendChild(errorDiv);
}

/**
 * Clear field error message
 */
function clearFieldError(field) {
    field.classList.remove('is-invalid');
    
    const errorDiv = field.parentNode.querySelector('.invalid-feedback');
    if (errorDiv) {
        errorDiv.remove();
    }
}

/**
 * Initialize auto-dismiss alerts
 */
function initializeAlerts() {
    const alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
    
    alerts.forEach(alert => {
        // Auto-dismiss after 5 seconds
        setTimeout(() => {
            if (alert.parentNode) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }
        }, 5000);
    });
}

/**
 * Show dynamic alert
 */
function showAlert(message, type = 'info', permanent = false) {
    const alertsContainer = document.querySelector('.container > .alert') ? 
        document.querySelector('.container > .alert').parentNode : 
        document.querySelector('.container');
    
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show ${permanent ? 'alert-permanent' : ''}`;
    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    alertsContainer.insertBefore(alertDiv, alertsContainer.firstChild);
    
    if (!permanent) {
        setTimeout(() => {
            if (alertDiv.parentNode) {
                const bsAlert = new bootstrap.Alert(alertDiv);
                bsAlert.close();
            }
        }, 5000);
    }
}

/**
 * Initialize loading states for buttons
 */
function initializeLoadingStates() {
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        form.addEventListener('submit', function() {
            const submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.classList.add('loading');
                submitBtn.disabled = true;
                
                // Re-enable after 10 seconds as fallback
                setTimeout(() => {
                    submitBtn.classList.remove('loading');
                    submitBtn.disabled = false;
                }, 10000);
            }
        });
    });
}

/**
 * Initialize character counters for textareas
 */
function initializeCharacterCounters() {
    const textareas = document.querySelectorAll('textarea[data-max-length]');
    
    textareas.forEach(textarea => {
        const maxLength = parseInt(textarea.dataset.maxLength);
        
        // Create counter element
        const counter = document.createElement('div');
        counter.className = 'form-text text-end';
        counter.innerHTML = `<span class="char-count">0</span> / ${maxLength}`;
        
        textarea.parentNode.appendChild(counter);
        
        // Update counter on input
        textarea.addEventListener('input', function() {
            const length = textarea.value.length;
            const countSpan = counter.querySelector('.char-count');
            
            countSpan.textContent = length;
            
            if (length > maxLength * 0.9) {
                counter.classList.add('text-warning');
                counter.classList.remove('text-muted');
            } else {
                counter.classList.remove('text-warning');
                counter.classList.add('text-muted');
            }
            
            if (length > maxLength) {
                counter.classList.add('text-danger');
                counter.classList.remove('text-warning');
            }
        });
        
        // Trigger initial update
        textarea.dispatchEvent(new Event('input'));
    });
}

/**
 * Initialize confirmation dialogs
 */
function initializeConfirmations() {
    const confirmButtons = document.querySelectorAll('[data-confirm]');
    
    confirmButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            const message = button.dataset.confirm;
            if (!confirm(message)) {
                e.preventDefault();
                return false;
            }
        });
    });
}

/**
 * Initialize responsive tables
 */
function initializeResponsiveTables() {
    const tables = document.querySelectorAll('.table:not(.table-responsive *)');
    
    tables.forEach(table => {
        if (!table.parentNode.classList.contains('table-responsive')) {
            const wrapper = document.createElement('div');
            wrapper.className = 'table-responsive';
            table.parentNode.insertBefore(wrapper, table);
            wrapper.appendChild(table);
        }
    });
}

/**
 * Utility function to format dates
 */
function formatDate(date, format = 'short') {
    const options = {
        short: { year: 'numeric', month: 'short', day: 'numeric' },
        long: { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' },
        time: { hour: '2-digit', minute: '2-digit' }
    };
    
    return new Intl.DateTimeFormat('en-US', options[format]).format(new Date(date));
}

/**
 * Utility function to debounce function calls
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Smooth scroll to element
 */
function scrollToElement(elementId, offset = 0) {
    const element = document.getElementById(elementId);
    if (element) {
        const elementPosition = element.getBoundingClientRect().top;
        const offsetPosition = elementPosition + window.pageYOffset - offset;
        
        window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
        });
    }
}

/**
 * Copy text to clipboard
 */
async function copyToClipboard(text) {
    try {
        await navigator.clipboard.writeText(text);
        showAlert('Copied to clipboard!', 'success');
    } catch (err) {
        console.error('Failed to copy: ', err);
        showAlert('Failed to copy to clipboard', 'danger');
    }
}

/**
 * Print current page
 */
function printPage() {
    window.print();
}

/**
 * Toggle dark mode (if implemented)
 */
function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
}

/**
 * Initialize dark mode from localStorage
 */
function initializeDarkMode() {
    if (localStorage.getItem('darkMode') === 'true') {
        document.body.classList.add('dark-mode');
    }
}

/**
 * Search functionality for tables
 */
function initializeTableSearch() {
    const searchInputs = document.querySelectorAll('[data-search-table]');
    
    searchInputs.forEach(input => {
        const tableId = input.dataset.searchTable;
        const table = document.getElementById(tableId);
        
        if (table) {
            input.addEventListener('input', debounce(function() {
                const searchTerm = input.value.toLowerCase();
                const rows = table.querySelectorAll('tbody tr');
                
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(searchTerm) ? '' : 'none';
                });
            }, 300));
        }
    });
}

/**
 * Handle AJAX form submissions
 */
function handleAjaxForm(formElement, successCallback) {
    formElement.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const formData = new FormData(formElement);
        const submitBtn = formElement.querySelector('button[type="submit"]');
        
        // Show loading state
        if (submitBtn) {
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;
        }
        
        try {
            const response = await fetch(formElement.action, {
                method: formElement.method,
                body: formData
            });
            
            if (response.ok) {
                const result = await response.json();
                if (successCallback) {
                    successCallback(result);
                }
                showAlert('Operation completed successfully!', 'success');
            } else {
                throw new Error('Request failed');
            }
        } catch (error) {
            console.error('Form submission error:', error);
            showAlert('An error occurred. Please try again.', 'danger');
        } finally {
            // Remove loading state
            if (submitBtn) {
                submitBtn.classList.remove('loading');
                submitBtn.disabled = false;
            }
        }
    });
}

// Export functions for global use
window.WauuLMS = {
    showAlert,
    formatDate,
    debounce,
    scrollToElement,
    copyToClipboard,
    printPage,
    toggleDarkMode,
    removeFilePreview,
    formatFileSize
};
