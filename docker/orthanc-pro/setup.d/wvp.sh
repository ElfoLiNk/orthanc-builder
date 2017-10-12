name=WVP
conf=osimis-webviewer-pro
settings=(STUDY_DOWNLOAD_ENABLED VIDEO_ENABLED ANNOTATIONS_STORAGE_ENABLED LIVESHARE_ENABLED LICENSE_STRING)
secrets=(LICENSE_STRING)
plugin=libOsimisWebViewerPro

if [[ $WVP_ALPHA_ENABLED == true ]]; then
	plugin=libOsimisWebViewerProAlpha
fi

function genconf {
	if [[ ! $LICENSE_STRING ]]; then
		log "Missing LICENSE_STRING setting, not generating configuration file"
		return 1
	fi
	cat <<-EOF >"$1"
	{
		"WebViewer": {
			"StudyDownloadEnabled": ${STUDY_DOWNLOAD_ENABLED:-true},
			"VideoDisplayEnabled": ${VIDEO_ENABLED:-true},
			"AnnotationStorageEnabled": ${ANNOTATIONS_STORAGE_ENABLED:-false},
			"LiveshareEnabled": ${LIVESHARE_ENABLED:-false},
			"LicenseString": "$LICENSE_STRING"
		}
	}
	EOF
}
