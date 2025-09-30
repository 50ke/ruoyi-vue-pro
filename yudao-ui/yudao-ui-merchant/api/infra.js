import { uploadFileRequest } from '@/utils/request'

export const infraApi = {
  // 文件上传
  uploadFile(filePath) {
	console.log(filePath)
    return uploadFileRequest({
      url: '/app-api/infra/file/upload',
      filePath: filePath
    })
  }
}