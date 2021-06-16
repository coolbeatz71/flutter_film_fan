String getInitials(String names) => names.isNotEmpty
    ? names.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';
